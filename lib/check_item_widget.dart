import 'package:flutter/material.dart';
import 'check_model.dart';

class CheckItemWidget extends StatelessWidget {
  final CheckItem check;

  const CheckItemWidget({required this.check});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 37,
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Изменено на MainAxisAlignment.start
            children: [
              Container( // Отступ слева от даты
                child: Text(check.date, style: TextStyle(fontSize: 15)),
              ),
              Container(
                width: 90, // Отступ от даты для текста названия магазина
                child: Center(
                  child: Text(
                    check.name.length > 90 ? '${check.name.substring(0, 90)}...' : check.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              Text('${check.sum.toStringAsFixed(2)} ₽', style: TextStyle(fontSize: 18)),
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
      ],
    );
  }
}
