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
import 'package:contactsbuddy/features/contact_mannager/data/data_sources/local/contact_manage_local_source_impl.dart';
import 'package:contactsbuddy/features/contact_mannager/data/data_sources/local/contact_manager_local_data_source.dart';
import 'package:contactsbuddy/features/contact_mannager/data/repository_impl/contact_manager_repository_impl.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/repository/contact_manager_repository.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/delete_conatct_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/get_all_conatcts_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/get_contact_by_id_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/update_contact_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/usecase/upload_conatct_usecase.dart';
import 'package:contactsbuddy/features/contact_mannager/presentation/bloc/bloc/contact_Manager/contact_manager_cubit.dart';
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

  sl.registerFactory<ContactManagerCubit>(() => ContactManagerCubit(
      getAllContactDataUsecase: sl.call(),
      getContactByIDUsecase: sl.call(),
      uploadConatctUsecase: sl.call(),
      updateConatctUsecase: sl.call(),
      deleteContactUsecase: sl.call()));

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

  //contact manager usecase

  sl.registerLazySingleton<UploadConatctDataUsecase>(
      () => UploadConatctDataUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetContactByIDUsecase>(
      () => GetContactByIDUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetAllContactDataUsecase>(
      () => GetAllContactDataUsecase(repository: sl.call()));
  sl.registerLazySingleton<UpdateConatctDataUsecase>(
      () => UpdateConatctDataUsecase(repository: sl.call()));
  sl.registerLazySingleton<DeleteConatctDataUsecase>(
      () => DeleteConatctDataUsecase(repository: sl.call()));

  //repositories
  sl.registerLazySingleton<AuthUserRepository>(
      () => AuthUserRepositoryImpl(localDataSource: sl.call()));
  sl.registerLazySingleton<ContactManagerRepository>(
      () => ContactManagerRepositoryImpl(localDataSource: sl.call()));

  //data source
  sl.registerLazySingleton<AuthUserLocalDataSource>(
      () => AuthUserLocalDataSourceImpl(db: sl.call()));
  sl.registerLazySingleton<ContactManagerLocalDataSource>(
      () => ContactManagerDataSourceImpl(db: sl.call()));

  //external
  final DbContext dbContext = DbContext.instance;
  final Database db = await dbContext.database;

  sl.registerLazySingleton(() => db);
}
