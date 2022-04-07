import 'dart:convert';

import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:eauc/uiscreens/individualpages/individual_auction_page.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/widgetmodels/blinking_live_indicator_large.dart';
import 'package:eauc/widgetmodels/display_auction_countdown.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../widgetmodels/get_auction_timestream.dart';

class AuctionInfoContainer extends StatefulWidget {
  final String auctionID, place;

  AuctionInfoContainer({required this.auctionID, required this.place});

  @override
  _AuctionInfoContainerState createState() => _AuctionInfoContainerState();
}

class _AuctionInfoContainerState extends State<AuctionInfoContainer> {
  bool _isPinned = false;
  bool _showLoading = false;
  late String emailid;
  final likebtnkey = GlobalKey<LikeButtonState>();

  Future<AuctionModel>? thisauction;
  Future<String>? functiondata;

  Future<AuctionModel> getAuctionData(String auctionid, String email) async {
    var auction, temp;
    var url = apiUrl + "AuctionData/getAuctionInfo.php";
    var response = await http.post(Uri.parse(url), body: {
      "auction_id": auctionid,
      "emailid": email,
    });
    temp = jsonDecode(response.body);
    _isPinned = temp['pinned_auctions'].split(",").contains(widget.auctionID);
    auction = auctionModelFromJson(response.body);
    return auction;
  }

  Future<String> pin_unpinauction(String auctionid, bool type) async {
    var url = apiUrl + "pinned_unpinned_auction.php";
    var response = await http.post(Uri.parse(url), body: {
      "future_state": (type) ? "pinned" : "unpinned",
      "email": emailid,
      "auction_id": auctionid,
    });
    return response.body;
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
          thisauction = getAuctionData(widget.auctionID, emailid);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final animationduration = Duration(milliseconds: 500);

    return FutureBuilder<AuctionModel>(
      future: thisauction,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return StreamBuilder<String>(
              stream:
                  GetAuctionTimeStream(widget.auctionID).getAuctionTimeStream(),
              builder: (context, timesnapshot) {
                if (!timesnapshot.hasData) {
                  return Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.all(2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 1,
                            ),
                            ShimmeringWidget(width: 120, height: 40)
                          ],
                        ),
                        Flexible(
                          child: Text(
                            snapshot.data!.result[0].auctionName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: kprimarycolor),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 100));
                                likebtnkey.currentState!.onTap();
                              },
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(8),
                                  backgroundColor:
                                      _isPinned ? Colors.blue : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side:
                                      BorderSide(color: Colors.blue, width: 2)),
                              child: IgnorePointer(
                                child: LikeButton(
                                  isLiked: _isPinned,
                                  key: likebtnkey,
                                  size: 23,
                                  animationDuration: animationduration,
                                  circleColor: CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isPinned) {
                                    return Icon(
                                      Icons.push_pin,
                                      color:
                                          isPinned ? Colors.white : Colors.blue,
                                      size: 23,
                                    );
                                  },
                                  likeCount: 0,
                                  countBuilder: (count, isPinned, text) {
                                    return Text(
                                      isPinned ? 'Pinned' : 'Pin Auction',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isPinned
                                              ? Colors.white
                                              : Colors.blue),
                                    );
                                  },
                                  onTap: (isPinned) async {
                                    setState(() {
                                      _showLoading = true;
                                    });
                                    // showToast(
                                    //   'Please wait...',
                                    //   context: context,
                                    //   animation: StyledToastAnimation.slideFromBottom,
                                    //   reverseAnimation:
                                    //       StyledToastAnimation.slideFromBottomFade,
                                    //   position: StyledToastPosition.center,
                                    //   animDuration: Duration(seconds: 1),
                                    //   duration: Duration(seconds: 4),
                                    //   curve: Curves.elasticOut,
                                    //   reverseCurve: Curves.linear,
                                    // );
                                    var url =
                                        apiUrl + "pinned_unpinned_auction.php";
                                    var response =
                                        await http.post(Uri.parse(url), body: {
                                      "future_state":
                                          (isPinned) ? "unpinned" : "pinned",
                                      "email": emailid,
                                      "auction_id": widget.auctionID,
                                    });
                                    if (jsonDecode(response.body) == 'true') {
                                      setState(() {
                                        _isPinned = !isPinned;
                                        _showLoading = false;
                                      });
                                    } else {
                                      setState(() {
                                        _showLoading = false;
                                      });
                                      showToast(
                                        'Error. Please Try Again',
                                        context: context,
                                        animation: StyledToastAnimation
                                            .slideFromBottom,
                                        reverseAnimation: StyledToastAnimation
                                            .slideFromBottomFade,
                                        position: StyledToastPosition.center,
                                        animDuration: Duration(seconds: 1),
                                        duration: Duration(seconds: 4),
                                        curve: Curves.elasticOut,
                                        reverseCurve: Curves.linear,
                                      );
                                    }
                                    return (jsonDecode(response.body) == 'true')
                                        ? !isPinned
                                        : isPinned;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            _showLoading
                                ? CircularProgressIndicator(
                                    strokeWidth: 5,
                                  )
                                : SizedBox(
                                    width: 1,
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            (widget.place == 'individualproductpage')
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IndividualAuctionPage(
                                                    auctionID: widget.auctionID,
                                                    auctionName: snapshot.data!
                                                        .result[0].auctionName,
                                                  )));
                                    },
                                    child: Chip(
                                      label: Text('Go to Auction'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          side: BorderSide(
                                              color: Colors.green, width: 2)),
                                      backgroundColor: Colors.green,
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      avatar: Icon(
                                        Icons.add_to_home_screen,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 1,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            snapshot.data!.result[0].auctionDesc,
                            style:
                                kCardSubTitleTextStyle.copyWith(fontSize: 15),
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
                            snapshot.data!.result[0].email,
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold),
                          ),
                          tileColor: kprimarycolor,
                          // subtitle: Text(
                          //   'Company Details or name',
                          //   style: TextStyle(color: ksecondarycolor),
                          // ),
                        ),
                        ShimmeringWidget(width: 90, height: 50),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                } else {
                  String heading = timesnapshot.data!.toString().split('.')[0];
                  String time = timesnapshot.data!.toString().split('.')[1];
                  return Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    margin: EdgeInsets.all(2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 1,
                            ),
                            (heading == 'Scheduled Date')
                                ? SizedBox(
                                    width: 1,
                                  )
                                : BlinkingLiveIndicatorLarge(),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            snapshot.data!.result[0].auctionName,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: kprimarycolor),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 100));
                                likebtnkey.currentState!.onTap();
                              },
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.all(8),
                                  backgroundColor:
                                      _isPinned ? Colors.blue : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side:
                                      BorderSide(color: Colors.blue, width: 2)),
                              child: IgnorePointer(
                                child: LikeButton(
                                  isLiked: _isPinned,
                                  key: likebtnkey,
                                  size: 23,
                                  animationDuration: animationduration,
                                  circleColor: CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isPinned) {
                                    return Icon(
                                      Icons.push_pin,
                                      color:
                                          isPinned ? Colors.white : Colors.blue,
                                      size: 23,
                                    );
                                  },
                                  likeCount: 0,
                                  countBuilder: (count, isPinned, text) {
                                    return Text(
                                      isPinned ? 'Pinned' : 'Pin Auction',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: isPinned
                                              ? Colors.white
                                              : Colors.blue),
                                    );
                                  },
                                  onTap: (isPinned) async {
                                    setState(() {
                                      _showLoading = true;
                                    });
                                    // showToast(
                                    //   'Please wait...',
                                    //   context: context,
                                    //   animation: StyledToastAnimation.slideFromBottom,
                                    //   reverseAnimation:
                                    //       StyledToastAnimation.slideFromBottomFade,
                                    //   position: StyledToastPosition.center,
                                    //   animDuration: Duration(seconds: 1),
                                    //   duration: Duration(seconds: 4),
                                    //   curve: Curves.elasticOut,
                                    //   reverseCurve: Curves.linear,
                                    // );
                                    var url =
                                        apiUrl + "pinned_unpinned_auction.php";
                                    var response =
                                        await http.post(Uri.parse(url), body: {
                                      "future_state":
                                          (isPinned) ? "unpinned" : "pinned",
                                      "email": emailid,
                                      "auction_id": widget.auctionID,
                                    });
                                    if (jsonDecode(response.body) == 'true') {
                                      setState(() {
                                        _isPinned = !isPinned;
                                        _showLoading = false;
                                      });
                                    } else {
                                      setState(() {
                                        _showLoading = false;
                                      });
                                      showToast(
                                        'Error. Please Try Again',
                                        context: context,
                                        animation: StyledToastAnimation
                                            .slideFromBottom,
                                        reverseAnimation: StyledToastAnimation
                                            .slideFromBottomFade,
                                        position: StyledToastPosition.center,
                                        animDuration: Duration(seconds: 1),
                                        duration: Duration(seconds: 4),
                                        curve: Curves.elasticOut,
                                        reverseCurve: Curves.linear,
                                      );
                                    }
                                    return (jsonDecode(response.body) == 'true')
                                        ? !isPinned
                                        : isPinned;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            _showLoading
                                ? CircularProgressIndicator(
                                    strokeWidth: 5,
                                  )
                                : SizedBox(
                                    width: 1,
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            (widget.place == 'individualproductpage')
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IndividualAuctionPage(
                                                    auctionID: widget.auctionID,
                                                    auctionName: snapshot.data!
                                                        .result[0].auctionName,
                                                  )));
                                    },
                                    child: Chip(
                                      label: Text('Go to Auction'),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          side: BorderSide(
                                              color: Colors.green, width: 2)),
                                      backgroundColor: Colors.green,
                                      labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      avatar: Icon(
                                        Icons.add_to_home_screen,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 1,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            snapshot.data!.result[0].auctionDesc,
                            style:
                                kCardSubTitleTextStyle.copyWith(fontSize: 15),
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
                            snapshot.data!.result[0].email,
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold),
                          ),
                          tileColor: kprimarycolor,
                          // subtitle: Text(
                          //   'Company Details or name',
                          //   style: TextStyle(color: ksecondarycolor),
                          // ),
                        ),
                        ListTile(
                          leading: Icon(
                            (heading == 'Scheduled Date')
                                ? Icons.access_time
                                : Icons.alarm,
                            size: 40,
                          ),
                          iconColor: ksecondarycolor,
                          title: Text(
                            heading,
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold),
                          ),
                          tileColor: kprimarycolor,
                          // subtitle:
                          //     DisplayAuctionCountdown(auctionId: widget.auctionID),
                          subtitle: Text(
                            time,
                            style: TextStyle(
                                color: (heading == 'Scheduled Date')
                                    ? Colors.blue
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else
            return Center(
              child: Text('No data to display'),
            );
        } else
          return ShimmeringWidget(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
          );
      },
    );
  }
}
