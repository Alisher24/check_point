import 'package:flutter/cupertino.dart';

class CheckItem {
  final String date;
  final String storeName;
  final double amount;
  final List<ProductItem> products;

  CheckItem({required this.date, required this.storeName, required this.amount, required this.products});
}

class CategoryItem{
  final String name;
  final IconData icon;

  CategoryItem({required this.name, required this.icon});
}

class ProductItem {
  final String productName;
  final double productPrice;
  final double productPriceAll;
  final double kol;

  ProductItem({required this.productName, required this.productPrice, required this.kol, required this.productPriceAll});
}