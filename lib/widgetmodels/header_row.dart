import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class HeaderRow extends StatelessWidget {
  final String headerText;
  final VoidCallback onTap;

  HeaderRow({required this.headerText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerText,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                'See All',
                style: TextStyle(
                    color: kprimarycolor,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: kprimarycolor,
                size: 12,
              )
            ],
          ),
        ),
      ],
    );
  }
}
