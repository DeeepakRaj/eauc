import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/individualpages/individual_product_page.dart';
import 'package:eauc/widgetmodels/bid_inc_dec_container.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/get_auction_timestream.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';

class IapProductContainer extends StatefulWidget {
  final String imageName,
      auctionID,
      productID,
      productName,
      productDesc,
      auctionType,
      productPriceOrBid,
      hostEmail;
  final List<String> productTags;

  IapProductContainer(
      {required this.auctionType,
      required this.auctionID,
      required this.productID,
      required this.imageName,
      required this.productName,
      required this.productDesc,
      required this.productTags,
      required this.productPriceOrBid,
      required this.hostEmail});

  @override
  _IapProductContainerState createState() => _IapProductContainerState();
}

class _IapProductContainerState extends State<IapProductContainer> {
  late String emailid;

  int incrementValue(int? currentBid) {
    var len = currentBid.toString().length;
    if (len < 3) {
      return 5;
    }

    num ans = pow(10, len - 2);
    return ans.toInt();
  }

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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndividualProductPage(
                          auctionID: widget.auctionID,
                          productID: widget.productID,
                          productName: widget.productName)));
            },
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.2,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: Image.memory(base64Decode(widget.imageName)).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          StreamBuilder<String>(
            stream:
                GetAuctionTimeStream(widget.auctionID).getAuctionTimeStream(),
            builder: (context, timesnapshot) {
              if (!timesnapshot.hasData) {
                return Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.productName,
                                      style: kCardTitleTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 30,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: widget.productTags.length,
                                          itemBuilder: (context, index) {
                                            return TagContainer(
                                                widget.productTags[index]);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  ShimmeringWidget(width: 80, height: 20),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  ShimmeringWidget(width: 80, height: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.productDesc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        ShimmeringWidget(width: screenWidth * 0.8, height: 40),
                      ],
                    ),
                  ),
                );
              } else {
                String heading = timesnapshot.data!.toString().split('.')[0];
                String time = timesnapshot.data!.toString().split('.')[0];
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(widget.auctionID)
                      .doc(widget.productID)
                      .snapshots(),
                  builder: (context, bidsnapshot) {
                    if (!bidsnapshot.hasData) {
                      return Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.productName,
                                            style: kCardTitleTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 30,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    widget.productTags.length,
                                                itemBuilder: (context, index) {
                                                  return TagContainer(widget
                                                      .productTags[index]);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        ShimmeringWidget(width: 80, height: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ShimmeringWidget(width: 80, height: 20),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.productDesc,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              ShimmeringWidget(
                                  width: screenWidth * 0.8, height: 40),
                            ],
                          ),
                        ),
                      );
                    } else {
                      int _currentBid =
                          int.parse(bidsnapshot.data!.get('currentBid'));
                      return Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.productName,
                                            style: kCardTitleTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            height: 30,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    widget.productTags.length,
                                                itemBuilder: (context, index) {
                                                  return TagContainer(widget
                                                      .productTags[index]);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: ksecondarycolor,
                                          ),
                                          child: Text(
                                            (heading == 'Scheduled Date')
                                                ? 'OPENING BID'
                                                : 'CURRENT BID',
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _currentBid.toString(),
                                          style: TextStyle(
                                            color: Colors.brown,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.productDesc,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              _buildBiddingWidget(
                                  heading, _currentBid, widget.hostEmail),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBiddingWidget(String heading, int currentBid, String hostemail) {
    if (heading == 'Auction Ended') {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Auction has ended',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      );
    } else if (emailid == hostemail) {
      return SizedBox(
        height: 15,
      );
    } else if (heading == 'Scheduled Date') {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Bidding will start at the scheduled date and time',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      );
    } else {
      return BidIncDecContainer(
        auctionId: widget.auctionID,
        productId: widget.productID,
        minBid: (currentBid + incrementValue(currentBid)).toString(),
        from: 'individualauctionpage',
        email: emailid,
      );
    }
  }
}
