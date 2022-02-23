import 'package:flutter/material.dart';

class Product {
  late String productName;
  late String productDesc;
  late String productPrice;
  late List<String> productTags;

  Product() {
    productName = 'No name available';
    productDesc = 'No description available';
    productPrice = 'No price available';
    productTags = [];
  }
}
