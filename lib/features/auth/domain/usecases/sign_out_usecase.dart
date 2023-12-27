import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';

class SignOutUsecase {
  final AuthUserRepository _repository;

  SignOutUsecase({required AuthUserRepository repository})
      : _repository = repository;

  Future<void> call() async {
    return await _repository.signOut();
  }
}
