import 'dart:convert';
import 'package:eauc/databasemodels/registrationPageModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const apiUrl = 'https://eauc2022.000webhostapp.com/';

Future<bool> savedIdPreference(String emailid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('emailid', emailid);
  print(emailid);
  return prefs.setString('emailid', emailid);
}

Future<String> getIdPreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? id;
  try {
    id = prefs.getString('emailid');
    return id!;
  } catch (e) {
    return 'No Email Attached';
  }
}

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
