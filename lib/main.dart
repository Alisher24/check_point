import 'package:check_point/add.dart';
import 'package:check_point/profile.dart';
import 'package:flutter/material.dart';
import 'package:check_point/QRScannerPage.dart';
import 'package:check_point/check_model.dart';
import 'package:check_point/check_item_widget.dart';

class MainPage extends StatelessWidget {
  final List<CheckItem> checkitem = [
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 7100.00,
        products: [
          ProductItem(productName: 'Лапша Биг Бон говядина + соус томатный с базиликом + доширак в пакете', productPrice: 500.00, productPriceAll: 1000.00, kol: 2),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 1),
          ProductItem(productName: 'Творог 9%', productPrice: 200.00, productPriceAll: 800.00, kol: 4),
          ProductItem(productName: 'Творог 0%', productPrice: 100.00, productPriceAll: 500.00, kol: 5),
          ProductItem(productName: 'Сыр 50%', productPrice: 800.00, productPriceAll: 1600.00, kol: 2),
          ProductItem(productName: 'Протеин', productPrice: 1500.00, productPriceAll: 1500.00, kol: 1),
          ProductItem(productName: 'Креатин', productPrice: 1500.00, productPriceAll: 1500.00, kol: 1),
          ProductItem(productName: 'Гейнер', productPrice: 1500.00, productPriceAll: 1500.00, kol: 1),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
    CheckItem(
        date: '21:02 23.11',
        storeName: 'Командор',
        amount: 1500.00,
        products: [
          ProductItem(productName: 'Филе курицы', productPrice: 500.00, productPriceAll: 500.00, kol: 3),
          ProductItem(productName: 'Филе индейки', productPrice: 1000.00, productPriceAll: 1000.00, kol: 3),
        ]),
  ];

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
                        SizedBox(height: 8),
                        // Кнопка "ЧекПоинт"
                        ElevatedButton(
                          onPressed: () {
                            // Добавьте обработчик нажатия для кнопки
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QRScannerPage()),
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
                            width: 400,
                            height: 1,
                          ),
                        ),
                        Container(
                          height: 280, // Установите фиксированную высоту списка
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Ваши блоки с чеками
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: checkitem.length,
                                  itemBuilder: (context, index) {
                                    return _buildCheckItem(context, checkitem[index]);
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

                      }),
                      _buildBottomBarButton(Icons.add, 'Добавить', () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => AddPage()),
                        );
                      }),
                      _buildBottomBarButton(Icons.person, 'Профиль',() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
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
                          _buildInfoText('${checkItem.storeName}'),
                          _buildInfoText('${checkItem.amount}'),
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
                          '${product.productName} x1',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Text(
                      '${product.productPrice.toStringAsFixed(2)} ₽',
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
                      'x${product.kol.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${product.productPriceAll.toStringAsFixed(2)} ₽',
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