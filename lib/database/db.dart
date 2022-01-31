import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://eauc2022.000webhostapp.com/';

class DB {
  Future<void> insertIntoDatabase(email, pwd, username, contact, addr, city,
      pincode, ustate, country) async {
    var url = apiUrl + "registerUser.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": email,
      "pwd": pwd,
      "username": username,
      "contact": contact,
      "addr": addr,
      "city": city,
      "pincode": pincode,
      "ustate": ustate,
      "country": country,
    });
    var data = jsonDecode(response.body);
    print("Response: " + response.body);
    print(data);
  }
}
