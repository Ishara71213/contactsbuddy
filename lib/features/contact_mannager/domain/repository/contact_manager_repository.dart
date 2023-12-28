import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';

abstract class ContactManagerRepository {
  Future<bool> uploadConatct(ContactEntity entity);
  Future<ContactEntity> getContactById(int id);
  Future<List<ContactEntity>> getAllContacts();
  Future<bool> updateContact(ContactEntity entity);
  Future<bool> deleteContact(int id);
}
