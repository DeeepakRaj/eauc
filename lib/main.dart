import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/registration_page.dart';
import 'package:eauc/uiscreens/splashscreen.dart';
import 'package:eauc/uiscreens/wrapper.dart';
import 'package:flutter/material.dart';
import 'uiscreens/products/products.dart';
import 'uiscreens/home/home.dart';
import 'uiscreens/hosted/hosted.dart';
import 'uiscreens/auctions/auctions.dart';

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
          scaffoldBackgroundColor: kbackgroundcolor,
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: kprimarycolor),
            color: kbackgroundcolor,
            iconTheme: IconThemeData(color: kprimarycolor, size: 30),
            titleSpacing: 10,
            elevation: 0,
            centerTitle: true,
          ),
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
