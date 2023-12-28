import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/repository/contact_manager_repository.dart';

class UpdateConatctDataUsecase {
  final ContactManagerRepository _repository;

  UpdateConatctDataUsecase({required ContactManagerRepository repository})
      : _repository = repository;

  Future<bool> call(ContactEntity entity) async {
    return await _repository.updateContact(entity);
  }
}
