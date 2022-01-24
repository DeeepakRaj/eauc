import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ShadedContainer extends StatelessWidget {
  // ShadedContainer({required this.theTitle,required this.theRoute,required this.imgName,required this.theIcon});
  ShadedContainer(
      {required this.theTitle, required this.theRoute, required this.imgName});

  final String theTitle;
  final String imgName;
  final String theRoute;

  // final Icon theIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(theRoute, (Route<dynamic> route) => false);
      },
      child: Container(
        height: 150.0,
        width: 160.0,
        // padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
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
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/' + imgName + '.jpg',
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  theTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                      fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
