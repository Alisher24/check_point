import 'package:flutter/material.dart';
import 'package:check_point/main.dart';
import 'package:check_point/add.dart';
import 'package:check_point/vxod.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 42,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Большой круг на заднем фоне
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
            ),
          ),
          // Задний блок за центральным блоком с информацией
          Positioned(
            left: 38,  // 20 пикселей от левого края
            right: 38, // 20 пикселей от правого края
            top: 120,
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                color: Colors.green[500],
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('БЕТА-ВЕРСИЯ', style: TextStyle(color: Colors.grey)),
                        Text('Ivan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 320,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      _buildUserInfoRow('Фамилия', 'Гиль'),
                      _buildUserInfoRow('Имя', 'Иван'),
                      _buildUserInfoRow('Отчество', 'Владимирович'),
                      _buildUserInfoRow('Почта', 'evan.gil@list.ru'),
                      _buildUserInfoRow('Дата рождения', '10.02.2004'),
                      _buildUserInfoRow('Пароль', '****'),
                      ElevatedButton(
                        onPressed: () {
                          // Добавьте обработчик нажатия для кнопки "Изменить"
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          fixedSize: Size(200, 50), // Задаем ширину и высоту кнопки
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(10), // Задаем радиус скругления краев
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10), // Задаем радиус скругления краев
                            splashColor: Colors.grey, // Задаем цвет всплеска при нажатии
                            onTap: () {
                              // Добавьте обработчик нажатия для кнопки "Изменить"
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20), // Задаем радиус скругления краев для тени
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.transparent,
                                    spreadRadius: 0.5, // Устанавливаем значение для распределения тени
                                    blurRadius: 5, // Устанавливаем значение для размытия тени
                                    offset: Offset(0, 2), // Устанавливаем смещение тени
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
                  height: 60,
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
                      _buildBottomBarButton(Icons.home, 'Главная', (){
                        Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      }),
                      _buildBottomBarButton(Icons.add, 'Добавить', () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AddPage()),
                        );
                      }),
                      _buildBottomBarButton(Icons.person, 'Профиль',() {

                      }),
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
