import 'package:flutter/material.dart';
import 'package:check_point/main.dart';
import 'package:check_point/add.dart';
import 'package:check_point/vxod.dart';
import 'package:check_point/dateBase.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late User user; // или используйте вашу модель пользователя

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    int? loggedInUserId = DBProvider.db.getLoggedInUserId();
    if (loggedInUserId != null) {
      User? fetchedUser = await DBProvider.db.getUserData();
      if (fetchedUser != null) {
        setState(() {
          user = fetchedUser;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Большой круг на заднем фоне
          Positioned(
            child: Container(
              width: 415,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(110),
                  bottomRight: Radius.circular(110),
                ),
                shape: BoxShape.rectangle,
                color: Colors.green[500],
              ),
            ),
          ),
          // Задний блок за центральным блоком с информацией
          Positioned(
            left: 38, // 20 пикселей от левого края
            right: 38, // 20 пикселей от правого края
            top: 120,
            child: Container(
              height: 700,
              decoration: BoxDecoration(
                color: Colors.green[500],
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('БЕТА-ВЕРСИЯ', style: TextStyle(color: Colors.grey)),
                        Text(widget.user.login, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 320,
                  height: 646,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      _buildUserInfoRow('Фамилия', user?.lastName ?? ''),
                      _buildUserInfoRow('Имя', user?.firstName ?? ''),
                      _buildUserInfoRow('Отчество', user?.middleName ?? ''),
                      _buildUserInfoRow('Почта', user?.email ?? ''),
                      _buildUserInfoRow('Дата рождения', user?.birthday ?? ''),
                      SizedBox(height: 150),
                      ElevatedButton(
                        onPressed: () {
                          // Добавьте обработчик нажатия для кнопки "Изменить"
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditProfileDialog();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          fixedSize: Size(200, 50), // Задаем ширину и высоту кнопки
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: Colors.grey,
                            onTap: () {
                              // Добавьте обработчик нажатия для кнопки "Изменить"
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditProfileDialog();
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 0.5,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Изменить',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                  Icon(Icons.create, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 60.285,
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomBarButton(Icons.home, 'Главная', () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage(user: widget.user)),
                        );
                      }),
                      _buildBottomBarButton(Icons.category, 'Категории', () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AddPage(user: widget.user)),
                        );
                      }),
                      _buildBottomBarButton(Icons.person, 'Профиль', () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 46,
            width: 200,
            child: Stack(
              children: [
                Positioned(
                  bottom: 5,
                  child: Container(
                    height: 1,
                    width: 200,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarButton(IconData icon, String label, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              Text(label, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileDialog extends StatefulWidget {
  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  int? userId = DBProvider.db.getLoggedInUserId();


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: 400,
        height: 429,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.green,
            width: 3.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildTextField("Фамилия", lastNameController),
            _buildTextField("Имя", firstNameController),
            _buildTextField("Отчество", middleNameController),
            _buildTextField("Почта", emailController),
            _buildTextField("Дата рождения", birthdayController, isDateOfBirth: true),
            SizedBox(height: 20),
            Container(
              color: Colors.green[500],
              padding: EdgeInsets.symmetric(horizontal: 17.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _saveProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      'Сохранить',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Text(
                      'Назад',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfile() async {
    String lastName = lastNameController.text;
    String firstName = firstNameController.text;
    String middleName = middleNameController.text;
    String email = emailController.text;
    String dob = birthdayController.text;

    if (lastName.isEmpty ||
        firstName.isEmpty ||
        middleName.isEmpty ||
        email.isEmpty ||
        dob.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Ошибка"),
            content: Text("Все поля должны быть заполнены"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("ОК"),
              ),
            ],
          );
        },
      );
    } else {
      await DBProvider.db.updateUserData(userId!, firstName, lastName, middleName, email, dob);
      // Выполните необходимые действия с полученными значениями (например, отправка на сервер).
      Navigator.of(context).pop();
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isDateOfBirth = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 4),
          Container(
            height: 35,
            child: TextField(
              controller: controller,
              inputFormatters: isDateOfBirth ? [DateInputFormatter()] : [],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    if (filteredValue.length > 10) {
      filteredValue = filteredValue.substring(0, 10);
    }

    if (filteredValue.length >= 2 && filteredValue[2] != '.') {
      filteredValue = filteredValue.substring(0, 2) + '.' + filteredValue.substring(2);
    }

    if (filteredValue.length >= 5 && filteredValue[5] != '.') {
      filteredValue = filteredValue.substring(0, 5) + '.' + filteredValue.substring(5);
    }

    return TextEditingValue(
      text: filteredValue,
      selection: TextSelection.collapsed(offset: filteredValue.length),
    );
  }
}

