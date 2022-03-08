import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class ShadedContainer2 extends StatelessWidget {
  ShadedContainer2(
      {required this.theTitle,
      required this.cardColor,
      required this.textColor,
      required this.imgName});

  final String theTitle;
  final String imgName;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.width*0.35,
      // width: MediaQuery.of(context).size.width*0.30,
      // padding: EdgeInsets.all(5),
      height: 150,
      width: 160,
      margin: EdgeInsets.all(5),
      // padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Image.asset(
                'assets/images/' + imgName + '.jpg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: kprimarycolor,
              ),
              child: Text(
                theTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
