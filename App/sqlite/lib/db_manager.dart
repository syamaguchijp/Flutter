import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'logging.dart';
import 'user.dart';

class DBManager {

  static final String tableName = 'user_table';

  Database? _database;

  getMyDatabase() async {

    Logging.d("");
    if (_database != null) {
      return _database!;
    }
    _database = await _makeDB();
    return _database!;
  }

  Future<Database> _makeDB() async {

    Logging.d("");
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MyDatabase.db");
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {

    Logging.d("");
    await db.execute('''
          CREATE TABLE ${DBManager.tableName} (
            id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, birthday TEXT
          )
          ''');
  }

  Future<int> insert(User user) async {

    Logging.d("");
    final Database db = await getMyDatabase();
    return await db.insert(
      DBManager.tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> fetchUsers() async {

    Logging.d("");
    final Database db = await getMyDatabase();
    final List<Map<String, dynamic>> maps = await db.query(DBManager.tableName);
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        birthday: maps[i]['birthday'],
      );
    });
  }

  Future<int> update(User user, String name, String birthday) async {

    Logging.d("");
    final Database db = await getMyDatabase();
    var values = <String, dynamic>{
      "name": name,
      "birthday": birthday,
    };
    return await db.update(DBManager.tableName, values,
        where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> delete(User user) async {

    Logging.d("");
    final Database db = await getMyDatabase();
    return await db.delete(DBManager.tableName,
        where: 'id = ?', whereArgs: [user.id]);
  }

}