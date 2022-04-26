import 'dart:async';

import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/all_products_model.dart';
import 'package:eauc/databasemodels/auction_advanced_filter_model.dart';
import 'package:eauc/uiscreens/auctions/auctions_page_container.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:http/http.dart' as http;

class HostedAuctionsPage extends StatefulWidget {
  const HostedAuctionsPage({Key? key}) : super(key: key);

  @override
  _HostedAuctionsPageState createState() => _HostedAuctionsPageState();
}

class _HostedAuctionsPageState extends State<HostedAuctionsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text('My Hosted'),
              pinned: true,
              floating: true,
              snap: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: TabBar(
                indicatorColor: kprimarycolor,
                indicatorWeight: 4,
                    isScrollable: false,
                    labelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    labelColor: kprimarycolor,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'Auctions',
                    ),
                      ),
                  Tab(
                    child: Text(
                      'Products',
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: FutureBuilder<String>(
          future: getIdPreference(),
          builder: (context, emailsnapshot) {
            if (!emailsnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: kprimarycolor,
                ),
              );
            } else {
              if (emailsnapshot.data == 'No Email Attached') {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
                return Center(
                  child: CircularProgressIndicator(
                    color: kprimarycolor,
                  ),
                );
              } else {
                return TabBarView(
                  children: <Widget>[
                    HostedAuctions(
                      ownEmail: emailsnapshot.data!,
                    ),
                    HostedProducts(
                      ownEmail: emailsnapshot.data!,
                    ),
                  ],
                );
              }
            }
          },
        ),
      )),
    );
  }
}

class HostedAuctions extends StatefulWidget {
  final String ownEmail;

  HostedAuctions({required this.ownEmail});

  @override
  _HostedAuctionsState createState() => _HostedAuctionsState();
}

class _HostedAuctionsState extends State<HostedAuctions> {
  TextEditingController _searchAuctionsController = TextEditingController();
  Timer? debouncer;

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
    return Column(
      children: [
        SizedBox(height: 10),
        TextFormField(
          controller: _searchAuctionsController,
          cursorColor: kprimarycolor,
          style: kSearchFieldTextStyle,
          decoration: kSearchFieldDecoration.copyWith(
            hintText: 'Search in All Auctions',
            suffixIcon: GestureDetector(
              onTap: () {
                _searchAuctionsController.clear();
                FocusScopeNode currentFocus = FocusScope.of(context);

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
                if (_searchAuctionsController.text.isEmpty) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                }
              });
            });
          },
        ),
        SizedBox(
          height: 5,
        ),
        FutureBuilder<AuctionAdvancedFilterModel>(
          future: (_searchAuctionsController.text.isNotEmpty)
              ? getDifferentAuctionResults(_searchAuctionsController.text,
                  widget.ownEmail, 'All', '', '', widget.ownEmail)
              : getDifferentAuctionResults(
                  '', widget.ownEmail, 'All', '', '', widget.ownEmail),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView.builder(
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
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'No Auctions Hosted',
                    style: kHeaderTextStyle,
                  ),
                );
              }
            } else {
              return Expanded(
                child: GridView.builder(
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
                ),
              );
            }
          },
        )
      ],
    );
  }
}

class HostedProducts extends StatefulWidget {
  final String ownEmail;

  HostedProducts({required this.ownEmail});

  @override
  _HostedProductsState createState() => _HostedProductsState();
}

class _HostedProductsState extends State<HostedProducts> {
  TextEditingController _searchProductsController = TextEditingController();
  Timer? debouncer;

  Future<AllProductsModel> _getDifferentProductResults(
      String keyWord,
      String hostName,
      String auctionType,
      String dateFrom,
      String dateTo,
      String ownEmail,
      String category,
      String low_base_price,
      String high_base_price) async {
    var products;
    var url = apiUrl + "AuctionData/getProductAdvancedFilterData.php";
    var response = await http.post(Uri.parse(url), body: {
      "keyword": keyWord,
      "hostname": hostName,
      "type": auctionType,
      "start_date_from": dateFrom,
      "start_date_to": dateTo,
      "own_email": ownEmail,
      "category": category,
      "low_baseprice": low_base_price,
      "high_baseprice": high_base_price
    });
    products = allProductsModelFromJson(response.body);
    return products;
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
    return Column(
      children: [
        SizedBox(height: 10),
        TextFormField(
          controller: _searchProductsController,
          cursorColor: kprimarycolor,
          style: kSearchFieldTextStyle,
          decoration: kSearchFieldDecoration.copyWith(
            hintText: 'Search in All Auctions',
            suffixIcon: GestureDetector(
              onTap: () {
                _searchProductsController.clear();
                FocusScopeNode currentFocus = FocusScope.of(context);

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
                if (_searchProductsController.text.isEmpty) {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                }
              });
            });
          },
        ),
        FutureBuilder<AllProductsModel>(
          future: (_searchProductsController.text.isNotEmpty)
              ? _getDifferentProductResults(_searchProductsController.text,
                  widget.ownEmail, 'All', '', '', widget.ownEmail, '', '', '')
              : _getDifferentProductResults('', widget.ownEmail, 'All', '', '',
                  widget.ownEmail, '', '', ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          kAuctionsListViewWidth / kProductsListViewHeight,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.result.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: kProductsListViewHeight,
                        child: ProductsPageContainer(
                          auctionID: snapshot.data!.result[index].auctionId,
                          productName: snapshot.data!.result[index].productName,
                          productTags:
                              snapshot.data!.result[index].productCategory,
                          productID: snapshot.data!.result[index].productId,
                          hostName: snapshot.data!.result[index].host_email,
                          imageName: snapshot.data!.result[index].productImage,
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'No Products Hosted',
                    style: kHeaderTextStyle,
                  ),
                );
              }
            } else {
              return Expanded(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio:
                        kAuctionsListViewWidth / kProductsListViewHeight,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return ShimmeringWidget(
                        width: kAuctionsListViewWidth,
                        height: kProductsListViewHeight);
                  },
                ),
              );
            }
          },
        )
      ],
    );
  }
}

