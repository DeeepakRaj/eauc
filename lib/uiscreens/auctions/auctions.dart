import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:eauc/uiscreens/advanced_filter.dart';
import 'package:eauc/uiscreens/auctions/auctions_page_container.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:eauc/widgetmodels/header_row.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auctions extends StatefulWidget {
  static const routename = '/auctionspage';

  @override
  _AuctionsState createState() => _AuctionsState();
}

class _AuctionsState extends State<Auctions> {
  late String emailid;

  Future<AuctionModel>? allauctions;

  Future<AuctionModel> getAuctionData(String auctionid, String email) async {
    var auction;
    var url = apiUrl + "AuctionData/getAuctionInfo.php";
    var response = await http.post(Uri.parse(url), body: {
      "auction_id": auctionid,
      "emailid": email,
    });
    auction = auctionModelFromJson(response.body);
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
        });
        allauctions = getAuctionData('all', emailid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('AUCTIONS'),
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 10,
                    child: TextFormField(
                      cursorColor: kprimarycolor,
                      style: kSearchFieldTextStyle,
                      decoration: kSearchFieldDecoration.copyWith(
                        hintText: 'Search in All Auctions',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            //TODO: Clear the search field
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        //TODO: Build search list
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      splashRadius: 1,
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: kprimarycolor,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AdvancedFilter(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                              );
                            });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HeaderRow(
                          headerText: 'Ongoing Auctions',
                          onTap: () {
                            //TODO: Navigate to All Ongoing Auctions Page perhaps
                          }),
                      FutureBuilder<AuctionModel>(
                        future: allauctions,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              height: kAuctionsListViewHeight,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ShimmeringWidget(
                                      width: 180,
                                      height: kAuctionsListViewHeight,
                                    );
                                  }),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              height: kAuctionsListViewHeight,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ShimmeringWidget(
                                      width: 180,
                                      height: kAuctionsListViewHeight,
                                    );
                                  }),
                            );
                          } else {
                            if (snapshot.data!.result.length == 0)
                              return Center(
                                child: Text(
                                  'No actions at the moment',
                                  style: kHeaderTextStyle,
                                ),
                              );
                            return Container(
                              height: kAuctionsListViewHeight,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.result.length,
                                  itemBuilder: (context, index) {
                                    return AuctionsPageContainer(
                                      auctionID: snapshot
                                          .data!.result[index].auctionId,
                                      auctionName: snapshot
                                          .data!.result[index].auctionName,
                                      auctionDesc: snapshot
                                          .data!.result[index].auctionDesc,
                                      hostName:
                                          snapshot.data!.result[index].email,
                                      type: snapshot.data!.result[index].type,
                                      imageName: 'sampleimage1',
                                      time: '13/12/2022 13:23',
                                    );
                                  }),
                            );
                          }
                        },
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // HeaderRow(
                      //     headerText: 'Upcoming Auctions',
                      //     onTap: () {
                      //       //TODO: Navigate to All Ongoing Auctions Page perhaps
                      //     }),
                      // Container(
                      //   height: kAuctionsListViewHeight,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: ScrollPhysics(),
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 15,
                      //     itemBuilder: (context, index) {
                      //       return AuctionsPageContainer(
                      //         auctionID: '111',
                      //         auctionName: 'Coins Auction',
                      //         hostName: 'HostName',
                      //         type: 'upcoming',
                      //         imageName: 'sampleimage1',
                      //         time: '13/12/2022 13:23',
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
