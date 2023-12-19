import 'package:flutter/material.dart';
import 'QRScannerPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'dateBase.dart';

class NalogRuSession {
  NalogRuSession(String qr){
    getData(qr);
  }
  void getData(String qr) async {
    var url = Uri.parse('https://proverkacheka.com/api/v1/check/get');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var body = {'token': '25159.TyXlj8Ed9HTjamHZ3', 'qrraw': qr};

    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Успешный запрос!');
      // Получаем ответ от сервера
      var data = jsonDecode(response.body);
      await DBProvider.db.insertCheckData(data);
      // Выводим данные
      // for (var item in data['data']['json']['items']) {
      //   print('Название товара: ${item['name']}');
      //   print('Количество: ${item['quantity']}');
      //   print('Цена за единицу: ${item['price']}');
      //   print('Общая сумма: ${item['sum']}');
      //   print('---');
      // }
    } else {
      print('Ошибка запроса: ${response.statusCode}.');
    }
  }
}
