import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';

class GetCurrentUserByUidUsecase {
  final AuthUserRepository _repository;

  GetCurrentUserByUidUsecase({required AuthUserRepository repository})
      : _repository = repository;

  Future<UserEntity> call() async {
    return await _repository.getCurrentUserById();
  }
}
