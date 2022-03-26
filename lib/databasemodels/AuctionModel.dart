// To parse this JSON data, do
//
//     final auctions = auctionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AuctionModel> auctionsFromJson(String str) => List<AuctionModel>.from(
    json.decode(str).map((x) => AuctionModel.fromJson(x)));

String auctionsToJson(List<AuctionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuctionModel {
  AuctionModel({
    required this.auctionId,
    required this.auctionName,
    required this.auctionDesc,
    required this.startDate,
    required this.endDate,
    required this.email,
    required this.products,
  });

  final String auctionId;
  final String auctionName;
  final String auctionDesc;
  final DateTime startDate;
  final DateTime endDate;
  final String email;
  final List<Product> products;

  factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
        auctionId: json["auction_id"],
        auctionName: json["auction_name"],
        auctionDesc: json["auction_desc"],
        // startDate: DateTime.parse(json["start_Date"]),
        // endDate: DateTime.parse(json["end_Date"]),
        startDate: json["start_Date"],
        endDate: json["end_Date"],
        email: json["email"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "auction_id": auctionId,
        "auction_name": auctionName,
        "auction_desc": auctionDesc,
        "start_Date": startDate.toIso8601String(),
        "end_Date": endDate.toIso8601String(),
        "email": email,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.basePrice,
    required this.productCategory,
    required this.auctionId,
    required this.productImage,
    required this.moreProductImage,
  });

  final String productId;
  final String productName;
  final String productDesc;
  final String basePrice;
  final String productCategory;
  final String auctionId;
  final String productImage;
  final String moreProductImage;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        productName: json["product_name"],
        productDesc: json["product_desc"],
        basePrice: json["base_price"],
        productCategory: json["product_category"],
        auctionId: json["auction_id"],
        productImage: json["product_image"],
        moreProductImage: json["more_product_image"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_desc": productDesc,
        "base_price": basePrice,
        "product_category": productCategory,
        "auction_id": auctionId,
        "product_image": productImage,
        "more_product_image": moreProductImage,
      };
}
