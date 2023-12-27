import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';

class IsSignInUsecase {
  final AuthUserRepository _repository;

  IsSignInUsecase({required AuthUserRepository repository})
      : _repository = repository;

  Future<bool> call() async {
    return await _repository.isSignIn();
  }
}
