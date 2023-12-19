import 'package:flutter/material.dart';
import 'package:check_point/main.dart';
import 'package:check_point/profile.dart';
import 'package:check_point/check_model.dart';

class AddPage extends StatefulWidget {
  final String login;

  AddPage({required this.login});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final List<CategoryItem> categories = [
    CategoryItem(icon: Icons.menu_book, name: 'Книги'),
    CategoryItem(icon: Icons.bakery_dining_outlined, name: 'Выпечка'),
    CategoryItem(icon: Icons.wine_bar_outlined, name: 'Алкоголь'),
    CategoryItem(icon: Icons.home_repair_service, name: 'Товары для дома'),
    CategoryItem(icon: Icons.electrical_services, name: 'Электроника'),
    CategoryItem(icon: Icons.flatware, name: 'Кафе'),
    CategoryItem(icon: Icons.pets, name: 'Животные'),
    CategoryItem(icon: Icons.category, name: 'Категория 4'),
    CategoryItem(icon: Icons.category, name: 'Категория 4'),
    CategoryItem(icon: Icons.category, name: 'Категория 4'),
    CategoryItem(icon: Icons.category, name: 'Категория 4'),
    CategoryItem(icon: Icons.category, name: 'Категория 4'),
    CategoryItem(icon: Icons.category, name: 'Категория 4'),
    // Добавьте остальные категории
  ];


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
            left: 38,  // 20 пикселей от левого края
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
                        Text(widget.login, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text('47 283,75', style: TextStyle(fontSize: 45)),
                        // Разделительная линия
                        const ColoredBox(
                          color: Color.fromARGB(192, 192, 192, 192),
                          child: SizedBox(
                            width: 400,
                            height: 4,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Категории',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const ColoredBox(
                          color: Color.fromARGB(192, 192, 192, 192),
                          child: SizedBox(
                            width: 400,
                            height: 1,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Container(
                              height: 520,
                              child: ListView.separated(
                                padding: EdgeInsets.only(top: 0),
                                separatorBuilder: (context, index) => const ColoredBox(
                                  child: SizedBox(
                                    width: 400,
                                    height: 1,
                                  ),
                                  color: Color.fromARGB(192, 192, 192, 192),
                                ),
                                scrollDirection: Axis.vertical,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.only(left: 18),
                                  child:
                                  _buildCategoryItem(context, categories[index]),
                                  );
                                },
                              ),
                            )
                        ),
                        ColoredBox(
                          child: SizedBox(
                            width: 400,
                            height: 1,
                          ),
                          color: Color.fromARGB(192, 192, 192, 192),
                        ),
                        // Остальной код
                      ],
                    ),
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
                      _buildBottomBarButton(Icons.home, 'Главная', (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage(login: widget.login,)),
                        );
                      }),
                      _buildBottomBarButton(Icons.category, 'Категории', () {

                      }),
                      _buildBottomBarButton(Icons.person, 'Профиль',() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage(login: widget.login)),
                        );
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

  Widget _buildCategoryItem(BuildContext context, CategoryItem category) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {// Ваш код для модального окна
            return Dialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                width: 400,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.green,
                    width: 3.0,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ColoredBox(
                      color: Color.fromARGB(192, 192, 192, 192),
                      child: SizedBox(
                        width: 500,
                        height: 2,
                      ),
                    ),
                    // Блок с товарами
                    Expanded(
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return const Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                              ),
                              ColoredBox(
                                color: Color.fromARGB(192, 192, 192, 192),
                                child: SizedBox(
                                  width: 500,
                                  height: 2,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Кнопки "Изменить" и "Назад"
                    Container(
                      color: Colors.green[500], // Задаем цвет фона для контейнера с кнопкой "Назад"
                      padding: EdgeInsets.symmetric(horizontal: 17.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Ink(
                            decoration: BoxDecoration(
                              color: Colors.transparent, // Цвет кнопки "Назад"
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Text(
                                  'Назад',
                                  style: TextStyle(fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(category.icon),
            SizedBox(width: 10),
            Text(category.name),
          ],
        ),
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