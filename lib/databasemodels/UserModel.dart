import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.email,
    required this.pwd,
    required this.firstname,
    required this.lastname,
    required this.contact,
    required this.addr,
    required this.country,
    required this.states,
    required this.city,
    required this.pincode,
  });

  String email;
  String pwd;
  String firstname;
  String lastname;
  String contact;
  String addr;
  String country;
  String states;
  String city;
  String pincode;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        pwd: json["pwd"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        contact: json["contact"],
        addr: json["addr"],
        country: json["country"],
        states: json["states"],
        city: json["city"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "pwd": pwd,
        "firstname": firstname,
        "lastname": lastname,
        "contact": contact,
        "addr": addr,
        "country": country,
        "states": states,
        "city": city,
        "pincode": pincode,
      };
}
