import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  CustomOutlinedButton({required this.buttonText, required this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(15.0),
        backgroundColor: Colors.white,
        primary: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: kprimarycolor, width: 2)),
        textStyle: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w900, color: kprimarycolor),
      ),
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w900, color: kprimarycolor),
      ),
    );
  }
}
