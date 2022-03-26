import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:eauc/widgetmodels/blinking_live_indicator.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/widgetmodels/blinking_live_indicator_large.dart';
import 'package:eauc/widgetmodels/display_auction_countdown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuctionInfoContainer extends StatefulWidget {
  final String auctionID, place;

  AuctionInfoContainer({required this.auctionID, required this.place});

  @override
  _AuctionInfoContainerState createState() => _AuctionInfoContainerState();
}

class _AuctionInfoContainerState extends State<AuctionInfoContainer> {
  bool _isPinned = false;
  late String emailid;

  late Future<AuctionModel> thisauction;

  Future<AuctionModel> getAuctionData(String auctionid) async {
    var auction;
    var url = apiUrl + "AuctionData/getAuctionDataByID.php";
    var response = await http.post(Uri.parse(url), body: {
      "auction_id": auctionid,
    });
    print(response.statusCode);
    auction = auctionsFromJson(response.body);
    return auction;
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
          thisauction = getAuctionData(widget.auctionID);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuctionModel>(
      future: thisauction,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
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
                    BlinkingLiveIndicatorLarge(),
                  ],
                ),
                Flexible(
                  child: Text(
                    snapshot.data!.auctionName,
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
                    ChoiceChip(
                      label: _isPinned ? Text('Pinned') : Text('Pin Auction'),
                      labelStyle: _isPinned
                          ? TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)
                          : TextStyle(
                              fontSize: 12,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                      selected: _isPinned,
                      avatar: _isPinned
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            )
                          : Icon(
                              Icons.push_pin,
                              color: Colors.blueAccent,
                              size: 20,
                            ),
                      backgroundColor: Colors.white,
                      // elevation: 6,
                      // pressElevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          side: BorderSide(color: Colors.blueAccent, width: 2)),
                      selectedColor: Colors.blueAccent,
                      onSelected: (value) {
                        setState(() {
                          _isPinned = value;
                          // TODO: pinned or not function
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    (widget.place == 'individualproductpage')
                        ? Chip(
                            label: Text('Go to Auction'),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                side:
                                    BorderSide(color: Colors.green, width: 2)),
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
                    snapshot.data!.auctionDesc,
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
                    snapshot.data!.email,
                    style: TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.bold),
                  ),
                  tileColor: kprimarycolor,
                  // subtitle: Text(
                  //   'Company Details or name',
                  //   style: TextStyle(color: ksecondarycolor),
                  // ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.access_time,
                    size: 40,
                  ),
                  iconColor: ksecondarycolor,
                  title: Text(
                    'Ending In',
                    style: TextStyle(
                        color: Colors.brown, fontWeight: FontWeight.bold),
                  ),
                  tileColor: kprimarycolor,
                  // subtitle:
                  //     DisplayAuctionCountdown(auctionId: widget.auctionID),
                  subtitle: Text('12,14,15'),
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
  }
}
