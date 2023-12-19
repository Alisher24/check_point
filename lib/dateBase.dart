import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static final DBProvider db = DBProvider();
  Database? _database;
  int? _loggedInUserId;

  int? getLoggedInUserId() {
    return _loggedInUserId;
  }

  Future<void> getUserIdByLogin(String login) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      columns: ['id'],
      where: 'login = ?',
      whereArgs: [login],
    );

    if (results.isNotEmpty) {
      _loggedInUserId = await results.first['id'] as int;
    }
  }

  Future<Database> get database async{
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<void> updateUserData(int userId, String firstName, String lastName, String middleName, String email, String birthday) async {
    Database db = await database;
    await db.update(
      'users',
      {
        'first_name': firstName,
        'last_name': lastName,
        'surname': middleName,
        'email': email,
        'birthday': birthday,
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE users '
          '(id INTEGER PRIMARY KEY, '
          'login TEXT, password TEXT, '
          'first_name TEXT, '
          'last_name TEXT, '
          'surname TEXT, '
          'email TEXT, '
          'birthday TEXT)',);
      
      await db.execute('CREATE TABLE checks (id INTEGER PRIMARY KEY, user_id INTEGER, name TEXT, sum REAL)',);
    });
  }
}

class Check {
  int? id;
  int? userId;
  String name;
  double sum;

  Check({this.id, this.userId, required this.name, required this.sum});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'sum': sum,
    };
  }
}

class CheckProvider {
  Future<void> addCheck(Check check) async {
    final db = await DBProvider.db.database;
    await db.insert('checks', check.toMap());
  }

  Future<List<Check>> getChecksByUserId(int userId) async {
    final db = await DBProvider.db.database;
    final List<Map<String, dynamic>> maps =
    await db.query('checks', where: 'user_id = ?', whereArgs: [userId]);

    return List.generate(maps.length, (i) {
      return Check(
        id: maps[i]['id'],
        userId: maps[i]['user_id'],
        name: maps[i]['name'],
        sum: maps[i]['sum'],
      );
    });
  }
}

/*
class Data {
  Database? _database;

  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_credentials.db');
    _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE cheks (id INTEGER PRIMARY KEY, , name TEXT, sum REAL)',
      );
    });
  }
}*/
