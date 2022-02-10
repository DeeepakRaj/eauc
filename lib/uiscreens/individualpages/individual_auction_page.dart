import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class IndividualAuctionPage extends StatefulWidget {
  static const routename = 'individual_auction_page';

  @override
  _IndividualAuctionPageState createState() => _IndividualAuctionPageState();
}

class _IndividualAuctionPageState extends State<IndividualAuctionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product 1'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  //   color: Colors.white,
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.grey,
                  //       offset: Offset(0.0, 1.0), //(x,y)
                  //       blurRadius: 1.0,
                  //     ),
                  //   ],
                  // ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Coins Auction',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: kprimarycolor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Auction Description/////////////////////////////',
                        style: kCardSubTitleTextStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Titan Coins Pvt. Ltd',
                        style: TextStyle(
                          color: Colors.orangeAccent.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'titancoins@gmail.com',
                        style: TextStyle(
                            color: Colors.orangeAccent.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
