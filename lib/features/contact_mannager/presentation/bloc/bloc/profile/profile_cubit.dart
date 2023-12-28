import 'dart:io';

import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/update_profile_data_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UpdateProfileDataUsecase updateProfileDataUsecase;

  ProfileCubit({required this.updateProfileDataUsecase})
      : super(ProfileInitial());

  File? imageFile;
  XFile? imageFileCompressed;
  String profileImageUrl = "";

  Future<XFile?> compressFile(File file) async {
    final filePath = file.absolute.path;
    final fileExtension = filePath.split('.').last.toLowerCase();
    final lastIndex = filePath.lastIndexOf('.');
    final splitted = filePath.substring(0, lastIndex);
    final outPath = "$splitted\_out.$fileExtension";
    var result;

    if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
      result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 20,
      );
    } else if (fileExtension == 'png') {
      // Compress PNG images
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.png);
    } else if (fileExtension == 'heic') {
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.heic);
    } else if (fileExtension == 'webp') {
      result = await FlutterImageCompress.compressAndGetFile(filePath, outPath,
          quality: 20, format: CompressFormat.webp);
    } else {
      return XFile(file.path);
    }
    return result;
  }

  void getFromCamera(BuildContext context) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        File hqFile = File(pickedFile.path);
        XFile? compressedFile = await compressFile(hqFile);

        imageFile = File(compressedFile!.path);
        //imageFileCompressed = compressedFile;
      } else {
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image capture error')));
    }
  }

  void getFromGallery(BuildContext context) async {
    var status = await Permission.storage.request();

    try {
      if (status.isGranted) {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (pickedFile != null) {
          File hqFile = File(pickedFile.path);
          XFile? compressedFile = await compressFile(hqFile);
          imageFile = File(compressedFile!.path);
          // final originalLength = await hqFile.length();
          // final compressedSize = await imageFile!.length();
        } else {
          return;
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Permission denied')));
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Image Selecting error')));
    }
  }

  void updateUserInfo({context, firstNameCtrl, lastNameCtrl, dobCtrl}) async {
    try {
      if (BlocProvider.of<UserCubit>(context).userData != null) {
        emit(ProfiledataUpdateLoading());
        UserEntity user = UserEntity(
          id: BlocProvider.of<UserCubit>(context).userData?.id,
          firstName: firstNameCtrl ??
              BlocProvider.of<UserCubit>(context)
                  .userData
                  ?.firstName
                  .toString(),
          lastName: lastNameCtrl ??
              BlocProvider.of<UserCubit>(context).userData?.lastName.toString(),
          email: BlocProvider.of<UserCubit>(context).userData?.email.toString(),
          dob: dobCtrl ??
              BlocProvider.of<UserCubit>(context).userData?.dob.toString(),
          imagePath: BlocProvider.of<UserCubit>(context)
              .userData
              ?.imagePath
              .toString(),
        );
        user = await updateProfileDataUsecase(user);
        if (user != null) {
          emit(ProfiledataUpdateSuccess());
        }
        BlocProvider.of<UserCubit>(context).userData = user;
        Future.delayed(const Duration(seconds: 2), () {
          emit(ProfileInitial());
        });
      } else {
        return;
      }
    } catch (ex) {
      emit(ProfiledataUpdateFailure());
      return;
    }
  }
}
