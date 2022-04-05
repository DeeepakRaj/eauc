import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class BidIncDecContainer extends StatefulWidget {
  String minBid, productId, auctionId, email;

  BidIncDecContainer(
      {required this.minBid,
      required this.productId,
      required this.auctionId,
      required this.email});

  @override
  _BidIncDecContainerState createState() => _BidIncDecContainerState();
}

class _BidIncDecContainerState extends State<BidIncDecContainer> {
  List<String> bidsList = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      //TODO: Increment
                      if (bidsList.length == 0) {
                        setState(() {
                          bidsList.add((int.parse(widget.minBid) +
                                  incrementValue(int.parse(widget.minBid)))
                              .toString());
                        });
                      } else {
                        setState(() {
                          bidsList.add((int.parse(bidsList.last) +
                                  incrementValue(int.parse(bidsList.last)))
                              .toString());
                        });
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: ksecondarycolor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                        ),
                        child: Center(
                            child: Text(
                          '+',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: kbackgroundcolor,
                    child: Center(
                      child: Text(
                        (bidsList.length == 0) ? widget.minBid : bidsList.last,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      if (bidsList.length != 0) {
                        setState(() {
                          bidsList.removeLast();
                        });
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: ksecondarycolor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Center(
                            child: Text(
                          '-',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ))),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomNormalButton(
            buttonText: 'PLACE BID',
            onPressed: () {
              // TODO: Change current bid in the database
              FirebaseFirestore.instance
                  .collection(widget.auctionId)
                  .doc(widget.productId)
                  .update({
                "currentBid":
                    (bidsList.length == 0) ? widget.minBid : bidsList.last,
                'bidUsers': {
                  widget.email:
                      (bidsList.length == 0) ? widget.minBid : bidsList.last,
                }
              }).then((value) {
                setState(() {
                  bidsList.clear();
                  showToast(
                    'Bid Placed Successfully',
                    context: context,
                    animation: StyledToastAnimation.slideFromBottom,
                    reverseAnimation: StyledToastAnimation.slideFromBottomFade,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear,
                  );
                });
              }).catchError((onError) {
                setState(() {
                  showToast(
                    'Error. Please Try Again',
                    context: context,
                    animation: StyledToastAnimation.slideFromBottom,
                    reverseAnimation: StyledToastAnimation.slideFromBottomFade,
                    position: StyledToastPosition.center,
                    animDuration: Duration(seconds: 1),
                    duration: Duration(seconds: 4),
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.linear,
                  );
                });
              });
            },
          ),
        ),
      ],
    );
  }
}
