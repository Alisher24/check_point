import 'dart:async';
import 'package:flutter/material.dart';
import 'QRScannerPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'dateBase.dart';

class NalogRuSession {
  NalogRuSession(String qr){
    getData(qr);
  }

  Future<Map<String, dynamic>> executePythonCode(List<dynamic> code, String retailPlace, String dateTime) async {
    Completer<Map<String, dynamic>> completer = Completer();

    try {
      var channel = IOWebSocketChannel.connect('ws://89.104.70.81:5000');

      channel.sink.add(json.encode({'code': code, 'retailPlace': retailPlace, 'dateTime': dateTime}));

      channel.stream.listen(
            (message) {
          var response = json.decode(message);
          if (response.containsKey('predictions')) {
            completer.complete(response); // Completer receives the result
            channel.sink.close();
          }
        },
        onDone: () {
          channel.sink.close();
        },
        onError: (error) {
          print('Ошибка: $error');
          channel.sink.close();
          completer.complete({}); // Completer receives an empty list in case of error
        },
      );
    } catch (e) {
      print('Ошибка при выполнении Python кода: $e');
      completer.complete({}); // Completer receives an empty list in case of error
    }

    return completer.future; // Return the future from the completer
  }

  Future<void> getData(String qr) async {
    var url = Uri.parse('https://proverkacheka.com/api/v1/check/get');
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var body = {'token': '25159.TyXlj8Ed9HTjamHZ3', 'qrraw': qr};

    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      print('Успешный запрос!');
      // Получаем ответ от сервера
      var data = jsonDecode(response.body);
      data = data['data']['json'];
      var res = await executePythonCode(data['items'], data['retailPlace'], data['dateTime']);
      print(res);
      await DBProvider.db.insertCheckData(res);
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
