// To parse this JSON data, do
//
//     final individualProductModel = individualProductModelFromJson(jsonString);

import 'dart:convert';

IndividualProductModel individualProductModelFromJson(String str) =>
    IndividualProductModel.fromJson(json.decode(str));

String individualProductModelToJson(IndividualProductModel data) =>
    json.encode(data.toJson());

class IndividualProductModel {
  IndividualProductModel({
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.basePrice,
    required this.productCategory,
    required this.auctionId,
    required this.productImage,
    required this.moreProductImage,
    required this.host_email,
  });

  String productId;
  String productName;
  String productDesc;
  String basePrice;
  String productCategory;
  String auctionId;
  String productImage;
  String moreProductImage;
  String host_email;

  factory IndividualProductModel.fromJson(Map<String, dynamic> json) =>
      IndividualProductModel(
          productId: json["product_id"],
          productName: json["product_name"],
          productDesc: json["product_desc"],
          basePrice: json["base_price"],
          productCategory: json["product_category"],
          auctionId: json["auction_id"],
          productImage: json["product_image"],
          moreProductImage: json["more_product_image"],
          host_email: json["host_email"]);

  Map<String, dynamic> toJson() =>
      {
        "product_id": productId,
        "product_name": productName,
        "product_desc": productDesc,
        "base_price": basePrice,
        "product_category": productCategory,
        "auction_id": auctionId,
        "product_image": productImage,
        "more_product_image": moreProductImage,
        "host_email": host_email,
      };
}
