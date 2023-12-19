import 'package:flutter/cupertino.dart';

class CheckItem {
  final int id;
  final String name;
  final double sum;
  final int user_id;
  final String date;
  final List<ProductItem> products;

  CheckItem({
    required this.id,
    required this.name,
    required this.sum,
    required this.user_id,
    required this.date,
    required this.products
  });
}

class ProductItem {
  final int id;
  final int checkId;
  final String name;
  final double price;
  final double quantity;

  ProductItem({
    required this.id,
    required this.checkId,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class CategoryItem{
  final String name;
  final IconData icon;

  CategoryItem({required this.name, required this.icon});
}