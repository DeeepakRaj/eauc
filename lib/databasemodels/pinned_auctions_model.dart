// To parse this JSON data, do
//
//     final pinnedAuctionModel = pinnedAuctionModelFromJson(jsonString);

import 'dart:convert';

PinnedAuctionModel pinnedAuctionModelFromJson(String str) =>
    PinnedAuctionModel.fromJson(json.decode(str));

String pinnedAuctionModelToJson(PinnedAuctionModel data) =>
    json.encode(data.toJson());

class PinnedAuctionModel {
  PinnedAuctionModel({
    required this.result,
  });

  List<Result> result;

  factory PinnedAuctionModel.fromJson(Map<String, dynamic> json) =>
      PinnedAuctionModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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
