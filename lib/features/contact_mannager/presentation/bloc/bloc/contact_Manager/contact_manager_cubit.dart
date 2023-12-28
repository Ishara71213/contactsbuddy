import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/delete_conatct_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/get_all_conatcts_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/get_contact_by_id_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/update_contact_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/upload_conatct_usecase.dart';
import 'dart:developer' as dev;
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'contact_manager_state.dart';

class ContactManagerCubit extends Cubit<ContactManagerState> {
  final UploadConatctDataUsecase uploadConatctUsecase;
  final UpdateConatctDataUsecase updateConatctUsecase;
  final DeleteConatctDataUsecase deleteContactUsecase;
  final GetContactByIDUsecase getContactByIDUsecase;
  final GetAllContactDataUsecase getAllContactDataUsecase;

  ContactManagerCubit(
      {required this.uploadConatctUsecase,
      required this.updateConatctUsecase,
      required this.deleteContactUsecase,
      required this.getContactByIDUsecase,
      required this.getAllContactDataUsecase})
      : super(ContactManagerInitial());

  String errorMsg = "";
  void disposeState() {}

  Future<void> uploadConatct({required ContactEntity entity}) async {
    emit(ContactCrudOptInitiate());
    try {
      bool result = await uploadConatctUsecase.call(entity);
      if (result) {
        emit(ContactCrudOptSuccess());
      } else {
        emit(ContactCrudOptFailed());
      }
    } on DatabaseException catch (e, stacktrace) {
      emit(ContactCrudOptFailed());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    } catch (e, stacktrace) {
      final error = e.toString();
      errorMsg = error;
      emit(ContactCrudOptFailed());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }

  Future<List<ContactEntity>> loadConatcts() async {
    emit(ContactDataLoading());
    List<ContactEntity> result = [];
    try {
      result = await getAllContactDataUsecase.call();
    } on DatabaseException catch (e, stacktrace) {
      errorMsg = e.toString();
      emit(ContactDataLoadingFailed());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    } catch (e, stacktrace) {
      final error = e.toString();
      errorMsg = error;
      emit(ContactDataLoadingFailed());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
    return result;
  }

  Future<void> deleteConatct({required ContactEntity entity}) async {
    emit(ContactCrudOptInitiate());
    try {
      bool result = await deleteContactUsecase.call(entity.id!);
      if (result) {
        emit(ContactCrudOptSuccess());
      } else {
        emit(ContactCrudOptFailed());
      }
    } on DatabaseException catch (e, stacktrace) {
      emit(ContactCrudOptFailed());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    } catch (e, stacktrace) {
      final error = e.toString();
      errorMsg = error;
      emit(ContactCrudOptFailed());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }
}
