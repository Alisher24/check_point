import 'dart:async';
import 'package:flutter/material.dart';
import 'package:check_point/vxod.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext _context;
  Color backgroundColor = Color.fromRGBO(237, 255, 242, 1.0); // Исходный цвет фона

  @override
  void initState() {
    super.initState();
    _context = context;
    Timer(Duration(seconds: 3), () {

      Timer(Duration(milliseconds: 500), () {
        // Задержка перед переходом на следующую страницу
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (_context) => const LoginPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: backgroundColor,
        child: Center(
          child: Image.asset('lib/LOGO.png'), // Путь к изображению
        ),
      ),
    );
  }
}
