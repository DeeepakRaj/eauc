import 'dart:convert';
import 'package:eauc/databasemodels/registrationPageModel.dart';
import 'package:http/http.dart' as http;

const apiUrl = 'https://eauc2022.000webhostapp.com/';

class DB {
  Future<RegistrationPageModel> insertIntoDatabase(email, pwd, firstname,
      lastname, contact, addr, city, pincode, states, country) async {
    var url = apiUrl + "registerUser.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": email,
      "pwd": pwd,
      "firstname": firstname,
      "lastname": lastname,
      "contact": contact,
      "addr": addr,
      "city": city,
      "pincode": pincode,
      "states": states,
      "country": country,
    });
    var data = jsonDecode(response.body);
    return RegistrationPageModel.fromJson(data);
  }
}
