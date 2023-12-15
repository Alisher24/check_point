import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_credentials.db');
    _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE users (id INTEGER PRIMARY KEY, login TEXT, password TEXT)',
      );
      await db.execute(
        'CREATE TABLE cheks (id INTEGER PRIMARY KEY, user_id INTEGER, FOREIGN KEY (user_id) REFERENCES users (id), name TEXT, sum REAL)',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
        centerTitle: true, // Центрирование заголовка
        titleSpacing: 0, // Отступ сверху для заголовка
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _loginController,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.blue),
              decoration: const InputDecoration(
                labelText: 'Логин',
                hintText: 'Введите логин',
                prefixIcon: Icon(Icons.person, color: Colors.blue),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Ограничение на цифры
                LengthLimitingTextInputFormatter(4), // Ограничение на 4 символа
              ],
              style: const TextStyle(color: Colors.red),
              decoration: const InputDecoration(
                labelText: 'Пароль',
                hintText: 'Введите пароль',
                prefixIcon: Icon(Icons.lock, color: Colors.red),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _registerUser(context);
              },
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) async {
    String login = _loginController.text;
    String password = _passwordController.text;

    if (login.isNotEmpty && _isNumeric(password)) {
      bool userExists = await _checkUserExists(login);
      if (!userExists) {
        await _saveUserCredentials(login, password);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check, color: Colors.green),
                SizedBox(width: 10),
                Text('Успешно'),
              ],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.close, color: Colors.red),
                SizedBox(width: 10),
                Text('Логин уже существует'),
              ],
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.close, color: Colors.red),
              SizedBox(width: 10),
              Text('Пожалуйста, введите корректные данные (логин и только цифры в пароле)'),
            ],
          ),
        ),
      );
    }
  }

  bool _isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  Future<bool> _checkUserExists(String login) async {
    final List<Map<String, dynamic>> maps = await _database!.query(
      'users',
      where: 'login = ?',
      whereArgs: [login],
    );
    return maps.isNotEmpty;
  }

  Future<void> _saveUserCredentials(String login, String password) async {
    await _database?.insert('users', {'login': login, 'password': password});
  }
}
