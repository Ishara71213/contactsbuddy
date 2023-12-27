import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';

abstract class AuthUserLocalDataSource {
  Future<bool> isSignIn();
  Future<UserEntity> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<int> getCurrentUId();
  Future<UserEntity> getCurrentUserById();
}
