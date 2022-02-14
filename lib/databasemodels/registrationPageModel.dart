import 'dart:convert';

RegistrationPageModel registrationPageModelFromJson(String str) =>
    RegistrationPageModel.fromJson(json.decode(str));

String registrationPageModelToJson(RegistrationPageModel data) =>
    json.encode(data.toJson());

class RegistrationPageModel {
  RegistrationPageModel({
    required this.result,
  });

  String result;

  factory RegistrationPageModel.fromJson(Map<String, dynamic> json) =>
      RegistrationPageModel(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
      };
}
