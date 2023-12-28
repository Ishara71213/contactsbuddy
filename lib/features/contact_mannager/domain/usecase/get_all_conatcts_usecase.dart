import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/repository/contact_manager_repository.dart';

class GetAllContactDataUsecase {
  final ContactManagerRepository _repository;

  GetAllContactDataUsecase({required ContactManagerRepository repository})
      : _repository = repository;

  Future<List<ContactEntity>> call() async {
    return await _repository.getAllContacts();
  }
}
