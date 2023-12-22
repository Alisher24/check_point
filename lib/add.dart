import 'package:flutter/material.dart';
import 'package:check_point/main.dart';
import 'package:check_point/profile.dart';
import 'package:check_point/check_model.dart';

import 'dateBase.dart';

class AddPage extends StatefulWidget {
  final User user;

  AddPage({required this.user});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  double sumAll = 0;
  Future<List<CategoryItem>> getCategoryPercentages() async {
    // Получите все товары из базы данных
    List<CheckItem> checks = await DBProvider.db.getCheck(widget.user.id);
    List<ProductItem> products = [];
    for (var check in checks) {
      sumAll += check.sum;
      products.addAll(check.products);
    }
    print(products);

    // Вычислите общую сумму товаров
    double totalSum = products.fold(0, (sum, product) => sum + product.price * product.quantity);

    // Группируйте товары по категориям
    Map<String, double> categorySums = {};

    for (var product in products) {
      String category = product.category ?? "Unknown"; // Значение по умолчанию, если category равно null

      if (categorySums.containsKey(category)) {
        categorySums[category] = (categorySums[category] ?? 0) + product.price * product.quantity; // Значение по умолчанию, если categorySums[category] равно null
      } else {
        categorySums[category] = product.price * product.quantity;
      }
    }

    // Преобразуйте результаты в список объектов CategoryItem
    List<CategoryItem> categoryItems = categorySums.entries.map((entry) {
      double percentage = double.parse((entry.value / totalSum * 100).toStringAsFixed(2));
      return CategoryItem(name: entry.key, procent: percentage, sum: double.parse(totalSum.toStringAsFixed(2)));
    }).toList();

    return categoryItems;
  }

  List<CategoryItem> categories = [];

  @override
  void initState() {
    super.initState();
    _updateCategories();
  }

  Future<void> _updateCategories() async {
    // Получите данные из метода getCategoryPercentages
    List<CategoryItem> updatedCategories = await getCategoryPercentages();

    // Обновите состояние виджета
    setState(() {
      categories = updatedCategories;
    });
    categories.forEach((element) {print((element.sum * element.procent) / 100);});
  }


  @override
  Widget build(BuildContext context) {
    var devicedata = MediaQuery.of(context);
    double heightt = MediaQuery.of(context).size.height;
    double containerHeight;
    if (devicedata.viewPadding.bottom > 0) {
      // Кнопки управления есть, учтем их высоту
      containerHeight = devicedata.size.height - devicedata.viewPadding.bottom;
      print(containerHeight);
      print(1);
    } else {
      // Кнопок управления нет, используем всю высоту экрана
      containerHeight = devicedata.size.height;
      print(containerHeight);
      print(1);
    }
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
            padding: const EdgeInsets.only(
                top: 80,
                bottom: 0
            ),
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
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text('${sumAll.toStringAsFixed(2)}', style: TextStyle(fontSize: 45)),
                        // Разделительная линия
                        const ColoredBox(
                          color: Color.fromARGB(192, 192, 192, 192),
                          child: SizedBox(
                            width: 400,
                            height: 4,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 17),
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
                                    padding: EdgeInsets.only(left: 18, right: 18),
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
                          MaterialPageRoute(builder: (context) => MainPage(user: widget.user,)),
                        );
                      }),
                      _buildBottomBarButton(Icons.category, 'Категории', () {

                      }),
                      _buildBottomBarButton(Icons.person, 'Профиль',() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)),
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
                width: 300,
                height: 200,
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
                    // Блок с товарами
                    Expanded(
                      child: ListView.builder(
                        // itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                                child: Text('${((category.sum * category.procent) / 100).toStringAsFixed(2)} ₽', style: TextStyle(fontSize: 25, color: Colors.black)),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    // Кнопки "Изменить" и "Назад"
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[500],
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
                      ),
                      // Задаем цвет фона для контейнера с кнопкой "Назад"
                      padding: EdgeInsets.symmetric(horizontal: 0),
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
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(category.name),
                SizedBox(width: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${category.procent} %'),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ColoredBox(
                  color: Colors.orange,
                  child: SizedBox(
                    width: category.procent * 2,
                    height: 5,
                  ),
                ),
                // Text('${((category.sum * categories[index].procent) / 100).toStringAsFixed(2)} ₽'),
              ],
            ),
          ]
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