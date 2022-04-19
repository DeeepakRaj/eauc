import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/individualpages/individual_auction_page.dart';
import 'package:eauc/widgetmodels/blinking_live_indicator.dart';
import 'package:eauc/widgetmodels/get_auction_timestream.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuctionsPageContainer extends StatefulWidget {
  final String auctionID, type, imageName, auctionName, auctionDesc, hostName;

  AuctionsPageContainer(
      {required this.auctionID,
      required this.type,
      required this.imageName,
      required this.auctionDesc,
      required this.auctionName,
      required this.hostName});

  @override
  _AuctionsPageContainerState createState() => _AuctionsPageContainerState();
}

class _AuctionsPageContainerState extends State<AuctionsPageContainer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: GetAuctionTimeStream(widget.auctionID).getAuctionTimeStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: kAuctionsListViewHeight,
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
                    // image: DecorationImage(
                    //   image: AssetImage(
                    //     'assets/images/' + imageName + '.jpg',
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Image.asset(
                    'assets/images/' + widget.imageName + '.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      widget.auctionName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kprimarycolor,
                      ),
                      minFontSize: 19,
                      maxLines: 1,
                      maxFontSize: 22,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ShimmeringWidget(width: 10, height: 10)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                    child: Text(
                  widget.auctionDesc,
                  style: kCardSubTitleTextStyle.copyWith(fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
                SizedBox(
                  height: 10,
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
                ShimmeringWidget(width: 140, height: 50)
              ],
            ),
          );
        } else {
          String heading = snapshot.data!.toString().split('.')[0];
          String time = snapshot.data!.toString().split('.')[1];
          return GestureDetector(
            onTap: () {
              _onContainerTapped(heading);
            },
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.35,
              // width: MediaQuery.of(context).size.width * 0.45,
              height: kAuctionsListViewHeight,
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
                      // image: DecorationImage(
                      //   image: AssetImage(
                      //     'assets/images/' + imageName + '.jpg',
                      //   ),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: Image.asset(
                      'assets/images/' + widget.imageName + '.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: AutoSizeText(
                          widget.auctionName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kprimarycolor,
                          ),
                          minFontSize: 19,
                          maxLines: 1,
                          maxFontSize: 22,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      (heading == 'Time Remaining')
                          ? BlinkingLiveIndicator()
                          : SizedBox(
                              width: 1,
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                      child: Text(
                    widget.auctionDesc,
                    style: kCardSubTitleTextStyle.copyWith(fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                  SizedBox(
                    height: 10,
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
              ),
            ),
          );
        }
      },
    );
  }

  void _onContainerTapped(String heading) {
    if (heading != 'Auction Ended') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IndividualAuctionPage(
                    auctionID: widget.auctionID,
                    auctionName: widget.auctionName,
                  )));
    } else {
      Fluttertoast.showToast(
          msg: 'Auction has Ended', toastLength: Toast.LENGTH_LONG);
    }
  }
}
