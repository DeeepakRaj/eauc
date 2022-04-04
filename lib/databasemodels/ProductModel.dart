// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.basePrice,
    required this.productCategory,
    required this.auctionId,
    required this.productImage,
    required this.moreProductImage,
  });

  String productId;
  String productName;
  String productDesc;
  String basePrice;
  String productCategory;
  String auctionId;
  String productImage;
  String moreProductImage;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
