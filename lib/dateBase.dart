import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
}