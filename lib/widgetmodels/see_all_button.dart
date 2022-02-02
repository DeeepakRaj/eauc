import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
