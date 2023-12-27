import 'dart:convert';

import 'package:contactsbuddy/core/constants/secreat_keys.dart';
import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';
import 'package:crypto/crypto.dart';

class SignUpUsecase {
  final AuthUserRepository _repository;

  SignUpUsecase({required AuthUserRepository repository})
      : _repository = repository;

  Future<void> call(UserEntity user) async {
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
    return await _repository.signUp(userWithPasswordHash);
  }
}
