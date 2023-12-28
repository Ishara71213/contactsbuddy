import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/get_current_user_by_uid_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final GetCurrentUIdUsecase getCurrentUIdUsecase;
  final GetCurrentUserByUidUsecase getCurrentUserByUidUsecase;
  String errorMsg = "";
  UserEntity? userData;

  UserCubit(
      {required this.signUpUsecase,
      required this.signInUsecase,
      required this.getCurrentUIdUsecase,
      required this.getCurrentUserByUidUsecase})
      : super(UserInitial());

  void disposeState() {
    errorMsg = "";
    userData = null;
  }

  Future<void> resetToInitialState() async {
    emit(UserInitial());
  }

  Future<void> getCurrrentUser() async {
    try {
      userData = await getCurrentUserByUidUsecase();
    } on DatabaseException catch (e, stacktrace) {
      emit(UserFailrue());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    } catch (e, stacktrace) {
      emit(UserFailrue());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUsecase.call(user);
      userData = await getCurrentUserByUidUsecase();
      emit(UserSuccess());
    } on DatabaseException catch (e, stacktrace) {
      emit(UserFailrue());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    } catch (e, stacktrace) {
      errorMsg = e.toString();
      emit(UserFailrue());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      if (user.password != user.confirmPassword) {
        errorMsg = "Both passwords Must match";
        emit(UserFailrue());
        return;
      }
      await signUpUsecase.call(user);
      emit(UserSuccess());
    } on DatabaseException catch (e, stacktrace) {
      emit(UserFailrue());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    } catch (e, stacktrace) {
      final error = e.toString();
      errorMsg = error;
      emit(UserFailrue());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }
}
