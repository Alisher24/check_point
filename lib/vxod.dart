import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:check_point/registration_page.dart';
import 'package:check_point/profile.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
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
    });
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

  Future<bool> _checkPasswordMatches(String login, String password) async {
    final List<Map<String, dynamic>> maps = await _database!.query(
      'users',
      where: 'login = ? AND password = ?',
      whereArgs: [login, password],
    );
    return maps.isNotEmpty;
  }

  Future<bool> _checkUserCredentials(String login, String password) async {
    if (login.isNotEmpty && _isNumeric(password)) {
      bool userExists = await _checkUserExists(login);

      if (userExists) {
        bool passwordMatches = await _checkPasswordMatches(login, password);
        return passwordMatches;
      }
    }

    return false;
  }

  Future<bool> performLoginCheck(String login, String password) async {
    return await _checkUserCredentials(login, password);
  }

  void _showLoginFailed(BuildContext context) {
    const snackBar = SnackBar(
      content: Row(
        children: [
          Icon(Icons.close, color: Colors.red),
          SizedBox(width: 8),
          Text('Ошибка входа'),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: const Padding(
          padding: EdgeInsets.only(left: 90, top: 110),
          child: Text('Добро пожаловать!'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneController,
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
              controller: _pinController,
              keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Ограничение на цифры
                  LengthLimitingTextInputFormatter(4), // Ограничение на 4 символа
                ],
              obscureText: true,
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
              onPressed: () async {
                String phone = _phoneController.text;
                String pin = _pinController.text;

                if (phone.isNotEmpty && pin.length == 4) {
                  bool isAuthenticated = await _checkUserCredentials(phone, pin);

                  if (isAuthenticated) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  } else {
                    _showLoginFailed(context);
                  }
                } else {
                  print("Пожалуйста, введите корректные данные");
                }
              },
              child: Text('Войти'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: const Text('Нет аккаунта?'),
            ),
          ],
        ),
      ),
    );
  }
}
