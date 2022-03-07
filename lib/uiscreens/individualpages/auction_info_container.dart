import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class AuctionInfoContainer extends StatefulWidget {
  const AuctionInfoContainer({Key? key}) : super(key: key);

  @override
  _AuctionInfoContainerState createState() => _AuctionInfoContainerState();
}

class _AuctionInfoContainerState extends State<AuctionInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.all(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'auctionnameherotag',
            child: Text(
              'Coins Auction',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: kprimarycolor),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              'Auction Description Auction Description Auction Description Auction Description Auction Description',
              style: kCardSubTitleTextStyle.copyWith(fontSize: 15),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Hosted By:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            selectedTileColor: Colors.white,
            selectedColor: Colors.white,
            leading: Icon(
              Icons.account_circle,
              size: 40,
            ),
            iconColor: ksecondarycolor,
            title: Text(
              'Titan Coins',
              style:
                  TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
            ),
            tileColor: kprimarycolor,
            subtitle: Text(
              'Company Details or name',
              style: TextStyle(color: ksecondarycolor),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.access_time,
              size: 40,
            ),
            iconColor: ksecondarycolor,
            title: Text(
              'Ending In',
              style:
                  TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
            ),
            tileColor: kprimarycolor,
            subtitle: Text(
              '12:14:50',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
