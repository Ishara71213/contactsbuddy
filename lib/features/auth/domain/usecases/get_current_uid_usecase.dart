import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';

class GetCurrentUIdUsecase {
  final AuthUserRepository _repository;

  GetCurrentUIdUsecase({required AuthUserRepository repository})
      : _repository = repository;

  Future<int> call() async {
    return await _repository.getCurrentUId();
  }
}
