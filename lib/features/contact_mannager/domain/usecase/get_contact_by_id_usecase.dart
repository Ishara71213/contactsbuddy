import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/repository/contact_manager_repository.dart';

class GetContactByIDUsecase {
  final ContactManagerRepository _repository;

  GetContactByIDUsecase({required ContactManagerRepository repository})
      : _repository = repository;

  Future<ContactEntity> call(int id) async {
    return await _repository.getContactById(id);
  }
}
