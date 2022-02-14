import 'package:flutter/material.dart';

import '../constants.dart';

class CustomNormalButton extends StatelessWidget {
  CustomNormalButton({required this.buttonText, required this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(15.0),
        backgroundColor: knormalbuttoncolor,
        primary: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), side: BorderSide.none),
        textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
