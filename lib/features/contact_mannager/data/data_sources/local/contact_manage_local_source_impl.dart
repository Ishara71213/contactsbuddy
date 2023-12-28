import 'package:contactsbuddy/core/constants/db_tables.dart';
import 'package:contactsbuddy/core/constants/storage_keys.dart';
import 'package:contactsbuddy/features/contact_mannager/data/data_sources/local/contact_manager_local_data_source.dart';
import 'package:contactsbuddy/features/contact_mannager/data/models/Contact_model.dart';
import 'package:contactsbuddy/features/contact_mannager/domain/entities/contact_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';

class ContactManagerDataSourceImpl extends ContactManagerLocalDataSource {
  final Database db;

  ContactManagerDataSourceImpl({required this.db});

  // ignore: prefer_const_constructors
  final secureStorage = FlutterSecureStorage();

  Future<int> getCurrentUId() async {
    String? userId = await secureStorage.read(key: StorageKeys.signedInUserId);
    if (userId != null && userId != "") {
      int uId = int.parse(userId);
      return uId;
    } else {
      return 0;
    }
  }

  @override
  Future<bool> deleteContact(int id) async {
    final result = await db.delete(
      DbTables.contacts,
      where: '${ContactsFields.id} = ?',
      whereArgs: [id],
    );
    if (result > 0) {
      return true;
    } else {
      throw Exception("Failded To delete data");
    }
  }

  @override
  Future<List<ContactEntity>> getAllContacts() async {
    final uid = await getCurrentUId();
    List<ContactEntity> filteredList = [];
    final result = await db.query(
      DbTables.contacts,
      columns: ContactsFields.columns,
      where: '${ContactsFields.createdUser} = ?',
      whereArgs: [uid],
    );
    List<ContactModel> contactModel =
        result.map((e) => ContactModel.fromJson(e)).toList();

    contactModel.forEach((element) {
      ContactEntity entity = ContactEntity(
        firstName: element.firstName,
        lastName: element.lastName,
        email: element.email,
        id: element.id,
        mobile: element.mobile,
        imagePath: element.imagePath,
        createdDate: element.createdDate,
        createdUser: element.createdUser,
      );
      // fetch inverse Order
      filteredList.insert(0, entity);
    });
    return filteredList;
  }

  @override
  Future<ContactEntity> getContactById(int id) async {
    final uid = await getCurrentUId();
    final maps = await db.query(
      DbTables.contacts,
      columns: ContactsFields.columns,
      where: '${ContactsFields.id} = ? AND ${ContactsFields.createdUser} = ?',
      whereArgs: [id, uid],
    );

    if (maps.isNotEmpty) {
      ContactModel result = ContactModel.fromJson(maps.first);

      ContactEntity entity = ContactEntity(
        firstName: result.firstName,
        lastName: result.lastName,
        email: result.email,
        id: result.id,
        mobile: result.mobile,
        imagePath: result.imagePath,
        createdDate: result.createdDate,
        createdUser: result.createdUser,
      );
      return entity;
    } else {
      throw Exception('No Contact found');
    }
  }

  @override
  Future<bool> updateContact(ContactEntity entity) async {
    ContactModel model = ContactModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      id: entity.id,
      mobile: entity.mobile,
      imagePath: entity.imagePath,
      createdDate: entity.createdDate,
      createdUser: entity.createdUser,
    );

    int id = await db.update(DbTables.contacts, model.toJson());
    if (id == 0) {
      throw Exception("Contact Data update failed");
    } else {
      return true;
    }
  }

  @override
  Future<bool> uploadConatct(ContactEntity entity) async {
    final uid = await getCurrentUId();
    ContactModel model = ContactModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      id: entity.id,
      mobile: entity.mobile,
      imagePath: entity.imagePath,
      createdDate: DateTime.now(),
      createdUser: uid,
    );

    final id = await db.insert(DbTables.contacts, model.toJson());
    if (id == 0) {
      throw Exception('Failed To create Contact');
    } else {
      return true;
    }
  }
}
