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
  final String auctionId, productId, hostEmail;

  IppBiddingContainer(
      {required this.productId,
      required this.auctionId,
      required this.hostEmail});

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
                              //TODO: Build bidding list
                              (emailid == widget.hostEmail)
                                  ? _buildBiddingListWidget()
                                  : _buildBiddingWidget(heading, _currentBid),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Widget _buildBiddingListWidget(){
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Table(
  //           columnWidths: {
  //             0: FlexColumnWidth(1),
  //             1: FlexColumnWidth(3),
  //             2: FlexColumnWidth(3),
  //           },
  //           children: [
  //             TableRow(
  //                 decoration: BoxDecoration(
  //                   color: Colors.blueGrey,
  //                   // borderRadius: BorderRadius.only(
  //                   //     topLeft: Radius.circular(5),
  //                   //     topRight: Radius.circular(5)),
  //                 ),
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(
  //                       'No.',
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(
  //                       'Bid.',
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(
  //                       'User.',
  //                       style: TextStyle(
  //                           fontSize: 12,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold),
  //                     ),
  //                   ),
  //                 ]),
  //           ],
  //         ),
  //         ConstrainedBox(
  //             constraints: BoxConstraints(
  //               maxHeight: MediaQuery.of(context).size.height*0.25,
  //               maxWidth: double.infinity,
  //             ),
  //             child: SingleChildScrollView(
  //               child: Table(
  //                 columnWidths: {
  //                   0: FlexColumnWidth(1),
  //                   1: FlexColumnWidth(3),
  //                   2: FlexColumnWidth(3),
  //                 },
  //                 children: [
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                   TableRow(
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                       ),
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'No.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'Bid.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Text(
  //                             'User.',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.blue.shade700,
  //                                 fontWeight: FontWeight.bold),
  //                           ),
  //                         ),
  //                       ]),
  //                 ],
  //               ),
  //             ))
  //       ],
  //     ),
  //   );
  // }

  Widget _buildBiddingListWidget() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection(widget.auctionId)
              .doc(widget.productId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ShimmeringWidget(width: double.infinity, height: 100);
            } else {
              return DataTable(
                sortColumnIndex: 0,
                sortAscending: false,
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) {
                    return Colors.blueGrey;
                  },
                ),
                headingTextStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                columns: [
                  DataColumn(label: Text('No')),
                  DataColumn(
                      label: Text(
                    'Bid',
                  )),
                  DataColumn(
                      label: Text(
                    'User',
                  )),
                ],
                rows: _createRows(snapshot.data!.get('bidUsers')),
              );
            }
          },
        ));
  }

  List<DataRow> _createRows(Map userBidMap) {
    print(userBidMap);
    List<DataRow> newList = userBidMap.entries
        .map((e) => DataRow(cells: [
              DataCell(Text('No')),
              DataCell(Text(e.key)),
              DataCell(Text(e.value)),
            ]))
        .toList();

    return newList;
  }

  Widget _buildBiddingWidget(String heading, int? currentBid) {
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
        auctionId: widget.auctionId,
        productId: widget.productId,
        minBid: (currentBid! + incrementValue(currentBid)).toString(),
        from: 'individualproductpage',
        email: emailid,
      );
    }
  }
}
