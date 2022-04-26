import 'dart:async';

import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:eauc/databasemodels/auction_advanced_filter_model.dart';
import 'package:eauc/uiscreens/advanced_filter_auction.dart';
import 'package:eauc/uiscreens/advanced_filter_product.dart';
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
  Future<AuctionModel>? allauctions;
  TextEditingController _searchAuctionsController = TextEditingController();
  Timer? debouncer;

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

  Future<AuctionAdvancedFilterModel> getDifferentAuctionResults(
    String keyWord,
    String hostName,
    String auctionType,
    String dateFrom,
    String dateTo,
    String ownEmail,
  ) async {
    var auctions;
    var url = apiUrl + "AuctionData/getAuctionAdvancedFilterData.php";
    var response = await http.post(Uri.parse(url), body: {
      "keyword": keyWord,
      "hostname": hostName,
      "type": auctionType,
      "start_date_from": dateFrom,
      "start_date_to": dateTo,
      "own_email": ownEmail
    });
    auctions = auctionAdvancedFilterModelFromJson(response.body);
    return auctions;
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
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
          child: FutureBuilder<String>(
            future: getIdPreference(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                String emailid = snapshot.data!;
                if (snapshot.data == 'No Email Attached') {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
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
                              controller: _searchAuctionsController,
                              decoration: kSearchFieldDecoration.copyWith(
                                hintText: 'Search in All Auctions',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _searchAuctionsController.clear();
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                debounce(() async {
                                  setState(() {
                                    if (_searchAuctionsController
                                        .text.isEmpty) {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);

                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                    }
                                  });
                                });
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
                                      return AdvancedFilterAuction(
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
                        child: (_searchAuctionsController.text.isEmpty)
                            ? SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AuctionsListView(
                                      ownEmail: emailid,
                                      hostName: '',
                                      auctionType: 'Live',
                                      headerTitle: 'Ongoing Auctions',
                                      dateTo: '',
                                      dateFrom: '',
                                      keyWord: '',
                                    ),
                                    AuctionsListView(
                                      ownEmail: emailid,
                                      hostName: '',
                                      auctionType: 'Upcoming',
                                      headerTitle: 'Upcoming Auctions',
                                      dateTo: '',
                                      dateFrom: '',
                                      keyWord: '',
                                    ),
                                  ],
                                ),
                              )
                            : _buildSearchResultView(emailid),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultView(String ownEmail) {
    return FutureBuilder<AuctionAdvancedFilterModel>(
        future: getDifferentAuctionResults(
            _searchAuctionsController.text, '', 'All', '', '', ownEmail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      kAuctionsListViewWidth / kAuctionsListViewHeight,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.result.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: kAuctionsListViewHeight,
                    child: AuctionsPageContainer(
                      auctionID: snapshot.data!.result[index].auctionId,
                      auctionName: snapshot.data!.result[index].auctionName,
                      hostName: snapshot.data!.result[index].email,
                      auctionDesc: snapshot.data!.result[index].auctionDesc,
                      type: 'Live',
                      imageName: 'sampleimage1',
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No Results Found',
                  style: kHeaderTextStyle,
                ),
              );
            }
          } else {
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:
                    kAuctionsListViewWidth / kAuctionsListViewHeight,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return ShimmeringWidget(
                    width: kAuctionsListViewWidth,
                    height: kAuctionsListViewHeight);
              },
            );
          }
        });
  }
}

class AuctionsListView extends StatelessWidget {
  final String headerTitle,
      keyWord,
      hostName,
      auctionType,
      dateFrom,
      dateTo,
      ownEmail;

  AuctionsListView({required this.headerTitle,
    required this.keyWord,
    required this.dateTo,
    required this.dateFrom,
    required this.hostName,
    required this.auctionType,
    required this.ownEmail});

  Future<AuctionAdvancedFilterModel> _getDifferentAuctionResults() async {
    var auctions;
    var url = apiUrl + "AuctionData/getAuctionAdvancedFilterData.php";
    var response = await http.post(Uri.parse(url), body: {
      "keyword": keyWord,
      "hostname": hostName,
      "type": auctionType,
      "start_date_from": dateFrom,
      "start_date_to": dateTo,
      "own_email": ownEmail,
    });
    auctions = auctionAdvancedFilterModelFromJson(response.body);
    return auctions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HeaderRow(
            headerText: headerTitle,
            onTap: () {
              //TODO: Navigate to All Ongoing Auctions Page perhaps
            }),
        FutureBuilder<AuctionAdvancedFilterModel>(
          future: _getDifferentAuctionResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.result.length != 0)
                  return Container(
                    height: kAuctionsListViewHeight,
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.result.length,
                        itemBuilder: (context, index) {
                          return AuctionsPageContainer(
                            auctionID: snapshot.data!.result[index].auctionId,
                            auctionName:
                            snapshot.data!.result[index].auctionName,
                            auctionDesc:
                            snapshot.data!.result[index].auctionDesc,
                            hostName: snapshot.data!.result[index].email,
                            type: snapshot.data!.result[index].type,
                            imageName: 'sampleimage1',
                          );
                        }),
                  );
                else
                  return Center(
                    child: Text(
                      'No Auctions Available',
                      style: kHeaderTextStyle,
                    ),
                  );
              } else {
                return Center(
                  child: Text(
                    'No Auctions Available',
                    style: kHeaderTextStyle,
                  ),
                );
              }
            } else {
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
            }
          },
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
