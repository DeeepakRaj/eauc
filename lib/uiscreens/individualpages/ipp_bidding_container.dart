import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/widgetmodels/bid_inc_dec_container.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../widgetmodels/get_auction_timestream.dart';

class IppBiddingContainer extends StatefulWidget {
  final String auctionId, productId;

  IppBiddingContainer({required this.productId, required this.auctionId});

  @override
  _IppBiddingContainerState createState() => _IppBiddingContainerState();
}

class _IppBiddingContainerState extends State<IppBiddingContainer> {
  late String emailid;
  int? _currentBid;

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
    return StreamBuilder<String>(
      stream: GetAuctionTimeStream(widget.auctionId).getAuctionTimeStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return ShimmeringWidget(width: 90, height: 50);
        } else {
          String heading = snapshot.data!.toString().split('.')[0];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
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
                      (heading == 'Scheduled Date')
                          ? 'Opening Bid'
                          : 'Current Bid',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(widget.auctionId)
                        .doc(widget.productId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'Loading...',
                        );
                      } else {
                        _currentBid =
                            int.parse(snapshot.data!.get('currentBid'));
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.get('currentBid'),
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
                              (heading == 'Scheduled Date')
                                  ? Center(
                                      child: Text(
                                        'Bidding will start at the scheduled date and time',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  : BidIncDecContainer(
                                      auctionId: widget.auctionId,
                                      productId: widget.productId,
                                      minBid: (_currentBid! +
                                              incrementValue(_currentBid))
                                          .toString(),
                                      from: 'ippbiddingcontainer',
                                      email: emailid,
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    // child: Container(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: [
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Text(
                    //         '400000',
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           color: Colors.brown,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 25,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //         child: IntrinsicHeight(
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.stretch,
                    //             children: [
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Container(
                    //                     decoration: BoxDecoration(
                    //                       color: ksecondarycolor,
                    //                       borderRadius: BorderRadius.only(
                    //                           topLeft: Radius.circular(10),
                    //                           bottomLeft: Radius.circular(10)),
                    //                     ),
                    //                     child: Center(
                    //                         child: Text(
                    //                           '+',
                    //                           style: TextStyle(
                    //                               fontSize: 40,
                    //                               color: Colors.white,
                    //                               fontWeight: FontWeight.bold),
                    //                         ))),
                    //               ),
                    //               Expanded(
                    //                 flex: 3,
                    //                 child: Container(
                    //                   color: kbackgroundcolor,
                    //                   child: Center(
                    //                     child: Text(
                    //                       '500',
                    //                       style: TextStyle(
                    //                           fontSize: 25,
                    //                           color: Colors.green,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Expanded(
                    //                 flex: 1,
                    //                 child: Container(
                    //                     decoration: BoxDecoration(
                    //                       color: ksecondarycolor,
                    //                       borderRadius: BorderRadius.only(
                    //                           topRight: Radius.circular(10),
                    //                           bottomRight: Radius.circular(10)),
                    //                     ),
                    //                     child: Center(
                    //                         child: Text(
                    //                           '-',
                    //                           style: TextStyle(
                    //                               fontSize: 40,
                    //                               color: Colors.white,
                    //                               fontWeight: FontWeight.bold),
                    //                         ))),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: CustomNormalButton(
                    //           buttonText: 'PLACE BID',
                    //           onPressed: () {
                    //             // TODO: Change current bid in the database
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
