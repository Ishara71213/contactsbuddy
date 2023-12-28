import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/domain/repository/auth_user_repository.dart';

class UpdateProfileDataUsecase {
  final AuthUserRepository _repository;

  UpdateProfileDataUsecase({required AuthUserRepository repository})
      : _repository = repository;

  Future<UserEntity> call(UserEntity entity) async {
    return await _repository.updateUserData(entity);
  }
}
