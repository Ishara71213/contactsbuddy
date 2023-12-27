import 'package:contactsbuddy/core/utils/db_context.dart';
import 'package:contactsbuddy/features/auth/data/data_sources/local/auth_user_local_data_source.dart';
import 'package:contactsbuddy/features/auth/data/data_sources/local/auth_user_local_source_impl.dart';
import 'package:contactsbuddy/features/auth/data/repository_impl/auth_user_repository_impl.dart';
import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/get_current_uid_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/get_current_user_by_uid_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/is_sign_in_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:contactsbuddy/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:contactsbuddy/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Bloc/cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUIdUsecase: sl.call(),
      isSignInUsecase: sl.call(),
      signOutUsecase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(
      signInUsecase: sl.call(),
      signUpUsecase: sl.call(),
      getCurrentUIdUsecase: sl.call(),
      getCurrentUserByUidUsecase: sl.call()));

  //usecase

  //--auth usecases
  sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(repository: sl.call()));

  sl.registerLazySingleton<IsSignInUsecase>(
      () => IsSignInUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIdUsecase>(
      () => GetCurrentUIdUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUserByUidUsecase>(
      () => GetCurrentUserByUidUsecase(repository: sl.call()));

  //repositories
  sl.registerLazySingleton<AuthUserRepository>(
      () => AuthUserRepositoryImpl(localDataSource: sl.call()));

  //data source
  sl.registerLazySingleton<AuthUserLocalDataSource>(
      () => AuthUserLocalDataSourceImpl(db: sl.call()));

  //external
  final DbContext dbContext = DbContext.instance;
  final Database db = await dbContext.database;

  sl.registerLazySingleton(() => db);
}
