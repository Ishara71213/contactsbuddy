import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/is_sign_in_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUsecase isSignInUsecase;
  final SignOutUsecase signOutUsecase;
  final GetCurrentUIdUsecase getCurrentUIdUsecase;

  AuthCubit(
      {required this.isSignInUsecase,
      required this.signOutUsecase,
      required this.getCurrentUIdUsecase})
      : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUsecase.call();
      if (isSignIn) {
        final uid = await getCurrentUIdUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } on DatabaseException catch (_) {
      emit(UnAuthenticated());
    } catch (e, stacktrace) {
      emit(UnAuthenticated());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }

  Future<void> signIn() async {
    try {
      final uid = await getCurrentUIdUsecase.call();
      emit(Authenticated(uid: uid));
    } on DatabaseException catch (_) {
      emit(UnAuthenticated());
    } catch (e, stacktrace) {
      emit(UnAuthenticated());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }

  Future<void> signOut() async {
    try {
      await signOutUsecase.call();
      emit(UnAuthenticated());
    } on DatabaseException catch (_) {
      emit(UnAuthenticated());
    } catch (e, stacktrace) {
      emit(UnAuthenticated());
      dev.log(e.toString(), name: "ERROR", stackTrace: stacktrace);
    }
  }
}
