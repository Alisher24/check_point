import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:check_point/dateBase.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: 415,
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(110),
                    bottomRight: Radius.circular(110),
                  ),
                  shape: BoxShape.rectangle,
                  color: Colors.green[500],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Регистрация',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(110),
                    topRight: Radius.circular(110),
                  ),
                  shape: BoxShape.rectangle,
                  color: Colors.green[500],
                ),
                child: Align(
                  alignment: Alignment.center,
                ),
              ),
            ),
            Positioned(
                child: Padding(
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
                        keyboardType: TextInputType.text,
                        inputFormatters: [
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
            ),
          ],
        ),
      ),
      ),
    );
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         TextField(
    //           controller: _loginController,
    //           keyboardType: TextInputType.text,
    //           style: const TextStyle(color: Colors.blue),
    //           decoration: const InputDecoration(
    //             labelText: 'Логин',
    //             hintText: 'Введите логин',
    //             prefixIcon: Icon(Icons.person, color: Colors.blue),
    //             enabledBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.blue),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.blue),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 16),
    //         TextField(
    //           controller: _passwordController,
    //           keyboardType: TextInputType.text,
    //           inputFormatters: [
    //           ],
    //           style: const TextStyle(color: Colors.red),
    //           decoration: const InputDecoration(
    //             labelText: 'Пароль',
    //             hintText: 'Введите пароль',
    //             prefixIcon: Icon(Icons.lock, color: Colors.red),
    //             enabledBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.red),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderSide: BorderSide(color: Colors.red),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 16),
    //         ElevatedButton(
    //           onPressed: () {
    //             _registerUser(context);
    //           },
    //           child: Text('Зарегистрироваться'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  void _registerUser(BuildContext context) async {
    String login = _loginController.text;
    String password = _passwordController.text;

    if (login.isNotEmpty && password.isNotEmpty) {
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
    Database db = await DBProvider.db.database;
    final List<Map<String, dynamic>> maps = await db!.query(
      'users',
      where: 'login = ?',
      whereArgs: [login],
    );
    return maps.isNotEmpty;
  }

  Future<void> _saveUserCredentials(String login, String password) async {
    Database db = await DBProvider.db.database;
    await db?.insert('users', {'login': login, 'password': password});
  }
}
