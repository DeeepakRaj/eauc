import 'package:eauc/constants.dart';
import 'package:eauc/login_page.dart';
import 'package:eauc/registration_page.dart';
import 'package:eauc/splashscreen.dart';
import 'package:eauc/uiscreens/wrapper.dart';
import 'package:flutter/material.dart';
import 'uiscreens/products.dart';
import 'uiscreens/home.dart';
import 'uiscreens/hosted.dart';
import 'uiscreens/auctions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eAuc',
      theme: ThemeData.light().copyWith(
          primaryColor: kprimarycolor,
          // primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              color: Colors.black,
            ),
            bodyText1: TextStyle(
              color: Colors.black,
            ),
          )),
      // home: SplashScreen(),
      home: RegistrationPage(),
      routes: {
        RegistrationPage.routename: (context) => RegistrationPage(),
        LoginPage.routename: (context) => LoginPage(),
        Wrapper.routename: (context) => Wrapper(),
        Products.routename: (context) => Products(),
        Home.routename: (context) => Home(),
        Auctions.routename: (context) => Auctions(),
        Hosted.routename: (context) => Hosted(),
      },
    );
  }
}
