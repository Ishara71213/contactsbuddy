import 'package:contactsbuddy/core/constants/db_name.dart';
import 'package:contactsbuddy/core/constants/db_tables.dart';
import 'package:contactsbuddy/features/auth/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DbContext {
  static final DbContext instance = DbContext._init();
  static Database? _database;

  DbContext._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb(DbNames.contactsBuddy);
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = "$dbPath$filePath";

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String textType = 'TEXT NOT NULL';
    //const String boolType = 'BOOLEAN NOT NULL';
    //const String integerType = 'INTEGER NOT NULL';

    await db.execute('''
          CREATE TABLE ${DbTables.users} (
            ${UsersFields.id} $idType,
            ${UsersFields.firstName} $textType,
            ${UsersFields.lastName} $textType,
            ${UsersFields.email} $textType,
            ${UsersFields.mobile} $textType,
            ${UsersFields.dob} $textType,
            ${UsersFields.gender} $textType,
            ${UsersFields.password} $textType,
            ${UsersFields.imagePath} $textType
          )
    ''');
  }

  Future<UserModel> create(UserModel model) async {
    final db = await instance.database;
    final id = await db.insert(DbTables.users, model.toJson());
    return model.copy(id: id);
  }

  Future<UserModel> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      DbTables.users,
      columns: UsersFields.columns,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
