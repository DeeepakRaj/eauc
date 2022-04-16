import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AllProductsModel.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:eauc/widgetmodels/display_auction_countdown.dart';
import 'package:eauc/widgetmodels/get_auction_timestream.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:eauc/databasemodels/IndividualProductModel.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/individualpages/auction_info_container.dart';
import 'package:eauc/uiscreens/individualpages/ipp_bidding_container.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/material.dart';

class IndividualProductPage extends StatefulWidget {
  final String auctionID, productID, productName;

  IndividualProductPage(
      {required this.auctionID,
      required this.productID,
      required this.productName});

  @override
  _IndividualProductPageState createState() => _IndividualProductPageState();
}

class _IndividualProductPageState extends State<IndividualProductPage> {
  Future<IndividualProductModel>? thisproduct;
  Future<AuctionModel>? thisauction;
  CarouselController _carouselController = CarouselController();
  late String emailid;
  Future<AllProductsModel>? thisauctionproducts;

  Future<AllProductsModel> getAuctionProducts(
      String auctionid, String productid) async {
    var products;
    var url = apiUrl + "AuctionData/getMoreProductsInAuction.php";
    var response = await http.post(Uri.parse(url), body: {
      "auction_id": auctionid,
      "product_id": productid,
    });
    print(response.statusCode);
    products = allProductsModelFromJson(response.body);
    return products;
  }

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

  Future<IndividualProductModel> getProductData(String productid) async {
    var product;
    var url = apiUrl + "AuctionData/getIndividualProductDetails.php";
    var response = await http.post(Uri.parse(url), body: {
      "product_id": productid,
    });
    product = individualProductModelFromJson(response.body);
    return product;
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
          thisproduct = getProductData(widget.productID);
          thisauction = getAuctionData(widget.auctionID, emailid);
          thisauctionproducts =
              getAuctionProducts(widget.auctionID, widget.productID);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.productName),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<IndividualProductModel>(
        future: thisproduct,
        builder: (context, productsnapshot) {
          if (productsnapshot.connectionState == ConnectionState.done) {
            if (productsnapshot.hasData) {
              var carouselImages =
                  productsnapshot.data!.moreProductImage.split(',');
              carouselImages.insert(0, productsnapshot.data!.productImage);
              var productTags =
                  productsnapshot.data!.productCategory.split('*');
              return ListView(
                children: [
                  Container(
                    color: Colors.black,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CarouselSlider.builder(
                          itemCount: carouselImages.length,
                          carouselController: _carouselController,
                          itemBuilder: (context, itemIndex, realIndex) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: Image.memory(base64Decode(
                                          carouselImages[itemIndex]))
                                      .image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            viewportFraction: 1,
                            pageSnapping: true,
                            autoPlay: false,
                            height: MediaQuery.of(context).size.height * 0.40,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _carouselController.previousPage(
                                    duration: Duration(milliseconds: 500));
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _carouselController.nextPage(
                                    duration: Duration(milliseconds: 500));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //Image Container
                  FutureBuilder<AuctionModel>(
                    future: thisauction,
                    builder: (auctioncontext, auctionsnapshot) {
                      if (auctionsnapshot.connectionState ==
                          ConnectionState.done) {
                        if (auctionsnapshot.hasData) {
                          return _buildAuctionDetailContainer(auctionsnapshot);
                        } else {
                          return Center(
                            child: Text(
                              'Unable to Load Auction. Please refresh the Page',
                              style: kHeaderTextStyle,
                            ),
                          );
                        }
                      } else {
                        return ShimmeringWidget(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25);
                      }
                    },
                  ),
                  Divider(
                    height: 8,
                    color: Colors.transparent,
                    thickness: 2,
                  ),
                  IppBiddingContainer(
                    productId: widget.productID,
                    auctionId: widget.auctionID,
                    hostEmail: productsnapshot.data!.host_email,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productsnapshot.data!.productName,
                          style: kCardTitleTextStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productTags.length,
                              itemBuilder: (context, index) {
                                return TagContainer(productTags[index]);
                              }),
                        ),
                        Divider(
                          height: 20,
                        ),
                        Text(
                          'About this item',
                          style: kHeaderTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          productsnapshot.data!.productDesc,
                          maxLines: 6,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 30,
                    color: Colors.transparent,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'More products in this auction',
                      style: kHeaderTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FutureBuilder<AllProductsModel>(
                      future: thisauctionproducts,
                      builder: (context, auctionproductssnapshot) {
                        if (auctionproductssnapshot.connectionState ==
                            ConnectionState.done) {
                          if (auctionproductssnapshot.hasData) {
                            return Container(
                              width: double.infinity,
                              height: kProductsListViewHeight,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: auctionproductssnapshot
                                      .data!.result.length,
                                  itemBuilder: (context, index) {
                                    return ProductsPageContainer(
                                      productID: auctionproductssnapshot
                                          .data!.result[index].productId,
                                      auctionID: auctionproductssnapshot
                                          .data!.result[index].auctionId,
                                      productTags: auctionproductssnapshot
                                          .data!.result[index].productCategory,
                                      productName: auctionproductssnapshot
                                          .data!.result[index].productName,
                                      imageName: auctionproductssnapshot
                                          .data!.result[index].productImage,
                                      hostName: auctionproductssnapshot
                                          .data!.result[index].host_email,
                                      currentBid: auctionproductssnapshot
                                          .data!.result[index].basePrice,
                                      type: 'Live',
                                      time: '12:14:15',
                                    );
                                  }),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No other products in this auction',
                                style: kHeaderTextStyle,
                              ),
                            );
                          }
                        } else {
                          return Container(
                            width: double.infinity,
                            height: kProductsListViewHeight,
                            child: ListView.separated(
                                separatorBuilder: (context, _) => SizedBox(
                                      width: 5,
                                    ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return ShimmeringWidget(
                                    width: 170,
                                    height: kProductsListViewHeight,
                                  );
                                }),
                          );
                        }
                      },
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Text(
                  'No Data to Display',
                  style: kHeaderTextStyle,
                ),
              );
            }
          } else {
            return ListView(
              children: [
                ShimmeringWidget(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35),
                SizedBox(
                  height: 20,
                ),
                ShimmeringWidget(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.25),
                SizedBox(
                  height: 20,
                ),
                ShimmeringWidget(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.45),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildAuctionDetailContainer(
      AsyncSnapshot<AuctionModel> auctionsnapshot) {
    return Container(
      width: double.infinity,
      // padding: EdgeInsets.all(10),
      color: Colors.white,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    _buildBottomSheet();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              auctionsnapshot.data!.result[0].auctionName,
                              style: kCardTitleTextStyle.copyWith(
                                  color: ksecondarycolor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.add_to_home_screen,
                            color: ksecondarycolor,
                            size: 20,
                          )
                        ],
                      ),
                      Flexible(
                        child: Text(
                          auctionsnapshot.data!.result[0].email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: StreamBuilder<String>(
                stream: GetAuctionTimeStream(widget.auctionID)
                    .getAuctionTimeStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ShimmeringWidget(width: 90, height: 50);
                  } else {
                    String heading = snapshot.data!.toString().split('.')[0];
                    String time = snapshot.data!.toString().split('.')[1];
                    return Container(
                      padding: EdgeInsets.all(5),
                      color: (heading == 'Scheduled Date')
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            heading,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.brown,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            time,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: (heading == 'Scheduled Date')
                                    ? Colors.blue
                                    : Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.4,
                        vertical: 4),
                    child: Divider(
                      height: 2,
                      color: Colors.grey,
                      thickness: 3,
                    ),
                  ),
                  Flexible(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: AuctionInfoContainer(
                          auctionID: widget.auctionID,
                          place: 'individualproductpage',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
