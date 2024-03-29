import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Product {
  late File primaryImage;
  late List<File> moreImages;
  late String productName;
  late String productDesc;
  late String openingBid;
  late List<String> productTags;

  Product() {
    productName = 'No name available';
    productDesc = 'No description available';
    openingBid = 'No price available';
    productTags = [];
  }
}
