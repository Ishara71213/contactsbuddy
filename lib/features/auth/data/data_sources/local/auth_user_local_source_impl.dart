import 'package:contactsbuddy/core/constants/db_tables.dart';
import 'package:contactsbuddy/core/constants/storage_keys.dart';
import 'package:contactsbuddy/features/auth/data/models/user_model.dart';
import 'package:contactsbuddy/features/auth/domain/entities/user_entity.dart';
import 'package:contactsbuddy/features/auth/data/data_sources/local/auth_user_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';

class AuthUserLocalDataSourceImpl extends AuthUserLocalDataSource {
  final Database db;

  AuthUserLocalDataSourceImpl({required this.db});

  // ignore: prefer_const_constructors
  final secureStorage = FlutterSecureStorage();

  @override
  Future<UserEntity> getCurrentUserById() async {
    final uid = await getCurrentUId();
    final maps = await db.query(
      DbTables.users,
      columns: UsersFields.columns,
      where: '${UsersFields.id} = ?',
      whereArgs: [uid],
    );

    if (maps.isNotEmpty) {
      UserModel authenticateUser = UserModel.fromJson(maps.first);
      return authenticateUser;
    } else {
      throw Exception('No user found');
    }
  }

  @override
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
  Future<bool> isSignIn() async {
    String? signedInUser =
        await secureStorage.read(key: StorageKeys.signedInUserId);
    if (signedInUser != "" && signedInUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> signOut() async =>
      await secureStorage.write(key: StorageKeys.signedInUserId, value: "");

  @override
  Future<void> signUp(UserEntity user) async {
    UserModel model = UserModel(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      mobile: user.mobile,
      password: user.password,
    );
    final id = await db.insert(DbTables.users, model.toJson());
    if (id == 0) {
      throw Exception('Failed To create User');
    }
  }

  @override
  Future<UserEntity> signIn(UserEntity user) async {
    final maps = await db.query(
      DbTables.users,
      columns: UsersFields.columns,
      where: '${UsersFields.email} = ? AND ${UsersFields.password} = ?',
      whereArgs: [user.email, user.password],
    );

    if (maps.isNotEmpty) {
      UserModel authenticateUser = UserModel.fromJson(maps.first);
      await secureStorage.write(
          key: StorageKeys.signedInUserId,
          value: authenticateUser.id?.toString());

      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('Email ${user.email} not found');
    }
  }

  @override
  Future<UserEntity> updateUserData(UserEntity entity) async {
    UserModel model = UserModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      mobile: entity.mobile,
      password: entity.password,
    );

    String? signedInUser =
        await secureStorage.read(key: StorageKeys.signedInUserId);
    if (signedInUser == "" || signedInUser == null) {
      throw Exception("Invalid User");
    }
    int id = await db.update(DbTables.users, model.toJson());
    if (id == 0) {
      throw Exception("User Data update failed");
    }
    return model;
  }
}
