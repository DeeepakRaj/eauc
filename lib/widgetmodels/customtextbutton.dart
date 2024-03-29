import 'package:flutter/material.dart';
import 'package:eauc/constants.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({required this.onPressed, required this.buttonText});

  final VoidCallback? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(15.0),
          backgroundColor:
              (onPressed == null) ? Colors.grey.shade400 : knormalbuttoncolor,
          primary: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), side: BorderSide.none),
          textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
        ));
  }
}
