import 'package:flutter/material.dart';

const kprimarycolor = Color(0xFFF0A500);
const kbackgroundcolor = Color(0xFFF4F4F4);
const kblacktextcolor = Colors.black;
const kinputfieldbgcolor = Color(0xFFEBF3FB);
const kinputfieldlabelcolor = Color(0xFFB0AFAF);
const knormalbuttoncolor = Color(0xFFF0A500);

final kTextInputDecoration = InputDecoration(
    hintText: 'Email',
    hintStyle: TextStyle(color: kinputfieldlabelcolor, fontSize: 21.0),
    fillColor: Colors.white,
    focusColor: Color(0xFFEBEBFB),
    filled: true,
    contentPadding: EdgeInsets.all(30.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.red, width: 2.0)));
