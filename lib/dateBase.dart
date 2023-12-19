import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:check_point/check_model.dart';

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

  Future<User?> getUserData() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [_loggedInUserId],
    );

    if (results.isNotEmpty) {
      return User.fromMap(results.first);
    } else {
      return null;
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
      
      await db.execute('CREATE TABLE checks (id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'sum REAL, '
          'user_id INTEGER, '
          'date TEXT,'
          'FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE)',);

      await db.execute('CREATE TABLE check_item (id INTEGER PRIMARY KEY, '
          'check_id INTEGER, '
          'name TEXT, '
          'price REAL, '
          'quantity REAL, '
          'FOREIGN KEY (check_id) REFERENCES checks (id) ON DELETE CASCADE ON UPDATE CASCADE)',);
    });
  }

  Future<void> insertCheckData(Map<String, dynamic> checkData) async {
    DateTime now = DateTime.now();
    String _addLeadingZero(int number) {
      return number.toString().padLeft(2, '0');
    }

    Database db = await database;

    // Вставка данных чека
    int checkId = await db.insert(
      'checks',
      {
        'name': checkData['data']['json']['user'],
        'date': "${now.year}/${_addLeadingZero(now.month)}/${_addLeadingZero(now.day)}",
        'user_id': _loggedInUserId,
      },
    );

    // Вставка данных товаров в чеке
    List<dynamic> items = checkData['data']['json']['items'];
    double totalSum = 0;

    for (var item in items) {
      await db.insert(
        'check_item',
        {
          'check_id': checkId,
          'name': item['name'],
          'price': (item['price']).toDouble() / 100,
          'quantity': item['quantity'],
        },
      );
      totalSum += ((item['price']).toDouble() / 100) * (item['quantity']).toDouble();
    }

    await db.update(
      'checks',
      {'sum': totalSum},
      where: 'id = ?',
      whereArgs: [checkId],
    );
  }

  Future<List<CheckItem>> getCheck() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query('checks');

    List<CheckItem> checkItems = [];

    for (var data in results) {
      int checkId = data['id'];

      List<ProductItem> products = await getCheckItemsByCheckId(checkId);

      CheckItem checkItem = CheckItem(
        id: data['id'],
        name: data['name'],
        sum: data['sum'],
        user_id: data['user_id'],
        date: data['date'],
        products: products,
      );

      checkItems.add(checkItem);
    }

    return checkItems;
  }

  Future<List<ProductItem>> getCheckItemsByCheckId(int checkId) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'check_item',
      where: 'check_id = ?',
      whereArgs: [checkId],
    );

    List<ProductItem> checkItems = results.map((data) {
      return ProductItem(
        id: data['id'],
        checkId: data['check_id'],
        name: data['name'],
        price: data['price'],
        quantity: data['quantity'],
      );
    }).toList();

    return checkItems;
  }
}


class User {
  int id;
  String login;
  String password;
  String firstName;
  String lastName;
  String middleName;
  String email;
  String birthday;

  User({
    required this.id,
    required this.login,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.email,
    required this.birthday,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      login: map['login'] as String? ?? '',
      password: map['password'] as String? ?? '',
      firstName: map['first_name'] as String? ?? '',
      lastName: map['last_name'] as String? ?? '',
      middleName: map['surname'] as String? ?? '',
      email: map['email'] as String? ?? '',
      birthday: map['birthday'] as String? ?? '',
    );
  }
}

// class Check {
//   final int id;
//   final String name;
//   final double sum;
//   final int user_id;
//   final String date;
//
//   Check({
//     required this.id,
//     required this.name,
//     required this.sum,
//     required this.user_id,
//     required this.date,
//   });
// }
//
// class CheckItem {
//   final int id;
//   final int checkId;
//   final String name;
//   final double price;
//   final double quantity;
//
//   CheckItem({
//     required this.id,
//     required this.checkId,
//     required this.name,
//     required this.price,
//     required this.quantity,
//   });
// }
