import 'package:flutter/material.dart';

const kprimarycolor = Color(0xFFF0A500);
const kbackgroundcolor = Color(0xFFF4F4F4);
const kblacktextcolor = Colors.black;
const kinputfieldbgcolor = Color(0xFFEBF3FB);
const kinputfieldlabelcolor = Color(0xFFB0AFAF);
const knormalbuttoncolor = Color(0xFFF0A500);
// const kbrowntextcolor = Color(0xFFB26E63);
const ksecondarycolor = Color(0xFFBF9954);

const String apiUrl = 'https://eauction2022.000webhostapp.com/';

String numberRegExp = r'^[0-9]*$';
String emailRegExp =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String passwordRegExp =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

double kProductsListViewHeight = 310;
double kAuctionsListViewHeight = 270;

final kInputFieldDecoration = InputDecoration(
    hintText: 'Email',
    hintStyle: TextStyle(color: kinputfieldlabelcolor, fontSize: 17.0),
    fillColor: Colors.white,
    focusColor: Color(0xFFEBEBFB),
    filled: true,
    contentPadding: EdgeInsets.all(20.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0)));

final kSearchFieldDecoration = InputDecoration(
  hintText: 'Search in All Auctions',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  prefixIcon: Icon(
    Icons.search,
    color: kprimarycolor,
  ),
  suffixIcon: Icon(
    Icons.close,
    color: Colors.grey,
  ),
  focusColor: kprimarycolor,
  hoverColor: kprimarycolor,
  prefixIconColor: kprimarycolor,
  contentPadding: EdgeInsets.all(10.0),
);

final kSmallInputFieldDecoration = InputDecoration(
  hintText: 'Search in All Auctions',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
  focusColor: kprimarycolor,
  hoverColor: kprimarycolor,
  prefixIconColor: kprimarycolor,
  contentPadding: EdgeInsets.all(10.0),
);

final kInputFieldTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 21.0,
);

final kSearchFieldTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 18,
);

final kHeaderTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

final kCardTitleTextStyle =
    TextStyle(fontWeight: FontWeight.w900, color: kprimarycolor, fontSize: 20);

final kCardSubTitleTextStyle = TextStyle(fontSize: 18, color: Colors.grey);