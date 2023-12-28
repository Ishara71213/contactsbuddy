import 'package:contactsbuddy/features/contact_mannager/domain/repository/contact_manager_repository.dart';

class DeleteConatctDataUsecase {
  final ContactManagerRepository _repository;

  DeleteConatctDataUsecase({required ContactManagerRepository repository})
      : _repository = repository;

  Future<bool> call(int id) async {
    return await _repository.deleteContact(id);
  }
}
