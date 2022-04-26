import 'dart:async';

import 'package:eauc/constants.dart';
import 'package:http/http.dart' as http;
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/all_products_model.dart';
import 'package:eauc/uiscreens/advanced_filter_product.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:eauc/uiscreens/products/shimmering_products.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:eauc/widgetmodels/header_row.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  static const routename = '/productspage';

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
  void initState() {
    super.initState();
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
        title: Text('PRODUCTS'),
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
                              controller: _searchProductsController,
                              decoration: kSearchFieldDecoration.copyWith(
                                hintText: 'Search in All Products',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _searchProductsController.clear();
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
                                    if (_searchProductsController
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
                                      return AdvancedFilterProduct(
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
                        child: (_searchProductsController.text.isEmpty)
                            ? SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ProductsListView(
                                      high_base_price: '',
                                      low_base_price: '',
                                      category: '',
                                      ownEmail: emailid,
                                      hostName: '',
                                      auctionType: 'Live',
                                      headerTitle: 'Ongoing Auctions',
                                      dateTo: '',
                                      dateFrom: '',
                                      keyWord: '',
                                    ),
                                    ProductsListView(
                                      high_base_price: '',
                                      low_base_price: '',
                                      category: '',
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
    return FutureBuilder<AllProductsModel>(
        future: _getDifferentProductResults(_searchProductsController.text, '',
            'All', '', '', ownEmail, '', '', ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GridView.builder(
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
                    height: kAuctionsListViewHeight,
                    child: ProductsPageContainer(
                      auctionID: snapshot.data!.result[index].auctionId,
                      productName: snapshot.data!.result[index].productName,
                      productTags: snapshot.data!.result[index].productCategory,
                      productID: snapshot.data!.result[index].productId,
                      hostName: snapshot.data!.result[index].host_email,
                      imageName: snapshot.data!.result[index].productImage,
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
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
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

class ProductsListView extends StatelessWidget {
  final String headerTitle,
      keyWord,
      hostName,
      auctionType,
      dateFrom,
      dateTo,
      ownEmail,
      category,
      low_base_price,
      high_base_price;

  ProductsListView({
    required this.headerTitle,
    required this.keyWord,
    required this.dateTo,
    required this.dateFrom,
    required this.hostName,
    required this.auctionType,
    required this.ownEmail,
    required this.category,
    required this.low_base_price,
    required this.high_base_price,
  });

  Future<AllProductsModel> _getDifferentProductResults() async {
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
        FutureBuilder<AllProductsModel>(
          future: _getDifferentProductResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.result.length != 0)
                  return Container(
                    height: kProductsListViewHeight,
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.result.length,
                        itemBuilder: (context, index) {
                          return ProductsPageContainer(
                            auctionID: snapshot.data!.result[index].auctionId,
                            productName:
                                snapshot.data!.result[index].productName,
                            productTags:
                                snapshot.data!.result[index].productCategory,
                            productID: snapshot.data!.result[index].productId,
                            hostName: snapshot.data!.result[index].host_email,
                            imageName:
                                snapshot.data!.result[index].productImage,
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
                        width: kAuctionsListViewWidth,
                        height: kProductsListViewHeight,
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
