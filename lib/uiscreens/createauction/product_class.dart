import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  late XFile primaryImage;
  late List<XFile> moreImages;
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
