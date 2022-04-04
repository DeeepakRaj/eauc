// To parse this JSON data, do
//
//     final auctionModel = auctionModelFromJson(jsonString);

import 'dart:convert';

AuctionModel auctionModelFromJson(String str) =>
    AuctionModel.fromJson(json.decode(str));

String auctionModelToJson(AuctionModel data) => json.encode(data.toJson());

class AuctionModel {
  AuctionModel({
    required this.pinnedAuctions,
    required this.result,
  });

  String pinnedAuctions;
  List<Result> result;

  factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
        pinnedAuctions: json["pinned_auctions"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pinned_auctions": pinnedAuctions,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.auctionId,
    required this.auctionName,
    required this.auctionDesc,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.email,
  });

  String auctionId;
  String auctionName;
  String auctionDesc;
  String startDate;
  String endDate;
  String type;
  String email;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        auctionId: json["auction_id"],
        auctionName: json["auction_name"],
        auctionDesc: json["auction_desc"],
        startDate: json["start_Date"],
        endDate: json["end_Date"],
        type: json["type"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "auction_id": auctionId,
        "auction_name": auctionName,
        "auction_desc": auctionDesc,
        "start_Date": startDate,
        "end_Date": endDate,
        "type": type,
        "email": email,
      };
}
