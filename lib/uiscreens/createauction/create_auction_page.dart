import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/individualpages/individual_auction_page.dart';
import 'package:flutter/material.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({Key? key}) : super(key: key);

  @override
  _CreateAuctionPageState createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Auction'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create ',
                        style: TextStyle(fontSize: 50, color: Colors.black),
                      ),
                      Text(
                        'Auction',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          color: kprimarycolor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Auction Details'),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Auction Name',
                    ),
                    cursorColor: kprimarycolor,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
