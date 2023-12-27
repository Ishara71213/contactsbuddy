import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/data/data_sources/local/auth_user_local_data_source.dart';
import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';

class AuthUserRepositoryImpl extends AuthUserRepository {
  final AuthUserLocalDataSource localDataSource;

  AuthUserRepositoryImpl({required this.localDataSource});

  @override
  Future<UserEntity> getCurrentUserById() async =>
      await localDataSource.getCurrentUserById();

  @override
  Future<int> getCurrentUId() async => await localDataSource.getCurrentUId();

  @override
  Future<bool> isSignIn() async => await localDataSource.isSignIn();

  @override
  Future<UserEntity> signIn(UserEntity user) async =>
      await localDataSource.signIn(user);

  @override
  Future<void> signOut() async => await localDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      await localDataSource.signUp(user);
}
