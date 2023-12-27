import 'dart:convert';

import 'package:contactsbuddy/core/constants/secreat_keys.dart';
import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';
import 'package:crypto/crypto.dart';

class SignInUsecase {
  final AuthUserRepository _repository;

  SignInUsecase({required AuthUserRepository repository})
      : _repository = repository;

  Future<UserEntity> call(UserEntity user) async {
    var key = utf8.encode(user.password!);
    var bytes = utf8.encode(SecretKeys.passwordHashSecret);
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);

    UserEntity userWithPasswordHash = UserEntity(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      mobile: user.mobile,
      password: digest.toString(),
    );
    return await _repository.signIn(userWithPasswordHash);
  }
}
