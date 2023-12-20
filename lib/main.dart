import 'package:check_point/add.dart';
import 'package:check_point/profile.dart';
import 'package:flutter/material.dart';
import 'package:check_point/QRScannerPage.dart';
import 'package:check_point/check_item_widget.dart';

import 'check_model.dart';
import 'dateBase.dart';

class MainPage extends StatefulWidget {
  final User user;

  MainPage({required this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<CheckItem> allCheckItems = [];
  double sumAll = 0;

  @override
  void initState() {
    super.initState();
    fetchCheckItems();
  }
  Future<void> fetchCheckItems() async {
    // Получение данных из базы данных
    try {
      List<CheckItem> checks = await DBProvider.db.getCheck(widget.user.id);
      setState(() {
        allCheckItems = checks;
      });
      checks.forEach((element) {sumAll+=element.sum; });
    } catch (e) {
      // Обработка ошибок, если не удалось получить данные
      print('Error fetching data: $e');
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
                        SizedBox(height: 8),
                        // Кнопка "ЧекПоинт"
                        ElevatedButton(
                          onPressed: () {
                            // Добавьте обработчик нажатия для кнопки
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QRScannerPage(user: widget.user)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              side: const BorderSide(
                                color: Color.fromARGB(192, 192, 192, 192),
                                width: 4.0,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              elevation: 0,
                              fixedSize: Size(300, 80), // Задаем ширину и высоту кнопки
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.qr_code, color: Colors.green, size: 50,),
                              SizedBox(width: 10), // Расстояние между иконкой и текстом
                              Text('ЧекПоинт', style: TextStyle(fontSize: 35, color: Colors.black)),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(20.0),
                                        width: 400, // Задаем желаемую ширину
                                        height: 250, // Задаем желаемую высоту
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20.0),
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 3.0,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Данная функция находится в разработке',
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center, // Центрируем текст
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5.0,
                                        right: 5.0,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop(); // Закрыть окно
                                          },
                                          child: Icon(Icons.close, color: Colors.grey, size: 40),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            side: const BorderSide(
                              color: Color.fromARGB(192, 192, 192, 192),
                              width: 4.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 0,
                            fixedSize: Size(300, 80),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.lock, color: Colors.grey, size: 50),
                              SizedBox(width: 10),
                              Text('Рекомендуем', style: TextStyle(fontSize: 25, color: Colors.grey)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8,),
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
                                'История',
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        const ColoredBox(
                          color: Color.fromARGB(192, 192, 192, 192),
                          child: SizedBox(
                            width: 320,
                            height: 1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          height: 330, // Установите фиксированную высоту списка
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Ваши блоки с чеками
                                ListView.builder(
                                  padding: EdgeInsets.only(top: 0),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: allCheckItems.length,
                                  itemBuilder: (context, index) {
                                    return _buildCheckItem(context, allCheckItems[index]);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
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

                      }),
                      _buildBottomBarButton(Icons.category, 'Категории', () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AddPage(user: widget.user)),
                        );
                      }),
                      _buildBottomBarButton(Icons.person, 'Профиль',() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user,)),
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

  Widget _buildCheckItem(BuildContext context, CheckItem checkItem) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
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
                    // Поверхностные данные
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoText('${checkItem.date}'),
                          _buildInfoText('${checkItem.name}'),
                          _buildInfoText('${checkItem.sum}'),
                        ],
                      ),
                    ),
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
                        itemCount: checkItem.products.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                                child: _buildProductItem(checkItem.products[index]),
                              ),
                              const ColoredBox(
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
      child: CheckItemWidget(check: checkItem),
    );
  }

  Widget _buildProductItem(ProductItem product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0),
                        child:
                        Text(
                          '${product.name} x1',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Text(
                      '${product.price.toStringAsFixed(2)} ₽',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  width: 500,
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'x${product.quantity.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${(product.price * product.quantity).toStringAsFixed(2)} ₽',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
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