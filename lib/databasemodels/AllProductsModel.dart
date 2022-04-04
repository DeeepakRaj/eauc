// To parse this JSON data, do
//
//     final auctionModel = auctionModelFromJson(jsonString);

import 'dart:convert';

AllProductsModel allProductsModelFromJson(String str) =>
    AllProductsModel.fromJson(json.decode(str));

String allProductsModelToJson(AllProductsModel data) =>
    json.encode(data.toJson());

class AllProductsModel {
  AllProductsModel({
    required this.result,
  });

  List<Result> result;

  factory AllProductsModel.fromJson(Map<String, dynamic> json) =>
      AllProductsModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.productId,
    required this.productName,
    required this.productDesc,
    required this.basePrice,
    required this.productCategory,
    required this.auctionId,
    required this.productImage,
    required this.moreProductImage,
    required this.email,
  });

  String productId;
  String productName;
  String productDesc;
  String basePrice;
  String productCategory;
  String auctionId;
  String productImage;
  String moreProductImage;
  String email;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        productId: json["product_id"],
        productName: json["product_name"],
        productDesc: json["product_desc"],
        basePrice: json["base_price"],
        productCategory: json["product_category"],
        auctionId: json["auction_id"],
        productImage: json["product_image"],
        moreProductImage: json["more_product_image"],
        email: json["email"],
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
        "email": email,
      };
}
