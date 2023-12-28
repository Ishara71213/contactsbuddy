import 'package:contactsbuddy/features/contact_mannager/data/data_sources/local/contact_manager_local_data_source.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/repository/contact_manager_repository.dart';

class ContactManagerRepositoryImpl extends ContactManagerRepository {
  final ContactManagerLocalDataSource localDataSource;

  ContactManagerRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ContactEntity>> getAllContacts() async {
    return await localDataSource.getAllContacts();
  }

  @override
  Future<ContactEntity> getContactById(int id) async {
    return await localDataSource.getContactById(id);
  }

  @override
  Future<bool> uploadConatct(ContactEntity entity) async {
    return await localDataSource.uploadConatct(entity);
  }

  @override
  Future<bool> deleteContact(int id) async {
    return await localDataSource.deleteContact(id);
  }

  @override
  Future<bool> updateContact(ContactEntity entity) async {
    return await localDataSource.updateContact(entity);
  }
}
