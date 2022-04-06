import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/individualpages/individual_auction_page.dart';
import 'package:eauc/uiscreens/individualpages/individual_product_page.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/material.dart';

import '../../widgetmodels/get_auction_timestream.dart';

class ProductsPageContainer extends StatefulWidget {
  final String type,
      imageName,
      productName,
      hostName,
      currentBid,
      time,
      productTags,
      productID,
      auctionID;

  ProductsPageContainer(
      {required this.type,
      required this.imageName,
      required this.productName,
      required this.hostName,
      required this.productTags,
      required this.productID,
      required this.auctionID,
      required this.currentBid,
      required this.time});

  @override
  _ProductsPageContainerState createState() => _ProductsPageContainerState();
}

class _ProductsPageContainerState extends State<ProductsPageContainer> {
  late String emailid;
  List<String>? producttags;

  @override
  void initState() {
    super.initState();
    producttags = widget.productTags.split(',');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualProductPage(
                      auctionID: widget.auctionID,
                      productID: widget.productID,
                      productName: widget.productName,
                    )));
      },
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.35,
        // width: MediaQuery.of(context).size.width * 0.45,
        height: kProductsListViewHeight,
        width: 180,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 180,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Image(
                  image: Image.memory(base64Decode(widget.imageName)).image,
                  fit: BoxFit.contain,
                )),
            SizedBox(
              height: 5,
            ),
            AutoSizeText(
              widget.productName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kprimarycolor,
              ),
              minFontSize: 19,
              maxLines: 1,
              maxFontSize: 22,
              overflow: TextOverflow.ellipsis,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     AutoSizeText(
            //       productName+'//////////////////////////////////////////',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         color: kprimarycolor,
            //       ),
            //       minFontSize: 19,
            //       maxLines: 1,
            //       maxFontSize: 22,
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //     Container(
            //       padding: EdgeInsets.all(2),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(3),
            //           color: Colors.lightGreen.shade100,
            //           border: Border.all(
            //               color: Colors.green.shade500
            //           )
            //       ),
            //       child: Text(
            //         'Live',
            //         maxLines: 1,
            //         style: TextStyle(
            //           color: Colors.green.shade500,
            //           fontSize: 12,
            //           fontWeight: FontWeight.bold
            //         ),
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Tags:',
              style: TextStyle(fontSize: 12),
            ),
            Flexible(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: producttags!.length,
                  itemBuilder: (context, index) {
                    return TagContainer(producttags![index]);
                  }),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Text(
                  'Host:',
                  style: TextStyle(fontSize: 12),
                ),
                Flexible(
                  child: AutoSizeText(
                    widget.hostName,
                    minFontSize: 15,
                    maxLines: 1,
                    maxFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: kprimarycolor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            StreamBuilder<String>(
              stream:
                  GetAuctionTimeStream(widget.auctionID).getAuctionTimeStream(),
              builder: (context, timesnapshot) {
                if (!timesnapshot.hasData) {
                  return ShimmeringWidget(width: 120, height: 50);
                } else {
                  String heading = timesnapshot.data!.toString().split('.')[0];
                  String time = timesnapshot.data!.toString().split('.')[1];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (heading == 'Scheduled Date')
                            ? 'Opening Bid'
                            : 'Current Bid',
                        style: TextStyle(fontSize: 12),
                      ),
                      StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(widget.auctionID)
                              .doc(widget.productID)
                              .snapshots(),
                          builder: (context, bidsnapshot) {
                            if (!bidsnapshot.hasData) {
                              return Text(
                                'Loading...',
                              );
                            } else {
                              int _currentBid = int.parse(
                                  bidsnapshot.data!.get('currentBid'));
                              return Flexible(
                                child: AutoSizeText(
                                  _currentBid.toString(),
                                  minFontSize: 25,
                                  maxLines: 1,
                                  maxFontSize: 27,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: ksecondarycolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                          }),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        heading,
                        style: TextStyle(fontSize: 12),
                      ),
                      Flexible(
                        child: AutoSizeText(
                          time,
                          textAlign: TextAlign.start,
                          minFontSize: (heading == 'Scheduled Date') ? 14 : 17,
                          maxFontSize: (heading == 'Scheduled Date') ? 16 : 19,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: (heading == 'Scheduled Date')
                                ? Colors.blue
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
