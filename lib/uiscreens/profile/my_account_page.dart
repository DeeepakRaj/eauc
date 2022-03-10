import 'package:eauc/widgetmodels/shaded_container2.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Account'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              ShadedContainer2(
                theTitle: 'My Account',
                cardColor: Colors.white,
                textColor: Colors.white,
                imgName: 'usericon',
              ),
              Align(
                alignment: Alignment(0, 0),
                child: Image.asset(
                  'assets/images/usericon.jpg',
                  height: 80,
                  width: 80,
                ),
              ),
            ],
          ),
        ));
  }
}
