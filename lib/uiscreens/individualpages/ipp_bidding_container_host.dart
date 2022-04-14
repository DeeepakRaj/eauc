import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';

class IppBiddingContainerHost extends StatefulWidget {
  final String auctionId, productId;

  IppBiddingContainerHost({required this.productId, required this.auctionId});

  @override
  _IppBiddingContainerHostState createState() =>
      _IppBiddingContainerHostState();
}

class _IppBiddingContainerHostState extends State<IppBiddingContainerHost> {
  late String emailid;

  @override
  void initState() {
    super.initState();
    getIdPreference().then((value) async {
      if (value == 'No Email Attached') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else {
        setState(() {
          this.emailid = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 10,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ksecondarycolor,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                  child: Text(
                    'Current Bid',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '400000',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
