import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AllProductsModel.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:http/http.dart' as http;

import 'auction_info_container.dart';
import 'iap_product_container.dart';

class IndividualAuctionPage extends StatefulWidget {
  static const routename = 'individual_auction_page';
  final String auctionID, auctionName;

  IndividualAuctionPage({required this.auctionID, required this.auctionName});

  @override
  _IndividualAuctionPageState createState() => _IndividualAuctionPageState();
}

class _IndividualAuctionPageState extends State<IndividualAuctionPage> {
  late String emailid;
  Future<AllProductsModel>? thisproducts;

  Future<AllProductsModel> getAuctionProducts(String auctionid) async {
    var products;
    var url = apiUrl + "AuctionData/getAllProducts.php";
    var response = await http.post(Uri.parse(url), body: {
      "auction_id": auctionid,
    });
    print(response.statusCode);
    products = allProductsModelFromJson(response.body);
    return products;
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
          thisproducts = getAuctionProducts(widget.auctionID);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.auctionName),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AuctionInfoContainer(
              auctionID: widget.auctionID,
              place: 'individualauctionpage',
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: StickyHeader(
                header: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  color: kbackgroundcolor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: kSearchFieldDecoration.copyWith(
                            hintText: 'Search in Products'),
                        textInputAction: TextInputAction.search,
                        style: kSearchFieldTextStyle,
                        cursorColor: kprimarycolor,
                        onChanged: (value) {
                          //TODO: Build search list view
                        },
                      ),
                    ],
                  ),
                ),
                content: FutureBuilder<AllProductsModel>(
                  future: thisproducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.result.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return IapProductContainer(
                                auctionType: 'Live',
                                auctionID:
                                    snapshot.data!.result[index].auctionId,
                                imageName:
                                    snapshot.data!.result[index].productImage,
                                productName:
                                    snapshot.data!.result[index].productName,
                                productID:
                                    snapshot.data!.result[index].productId,
                                productDesc:
                                    snapshot.data!.result[index].productDesc,
                                productTags: snapshot
                                    .data!.result[index].productCategory
                                    .split(','),
                                productPriceOrBid:
                                    snapshot.data!.result[index].basePrice,
                              );
                            });
                      } else {
                        return Center(
                          child: Text(
                            'No Products Available',
                            style: kHeaderTextStyle,
                          ),
                        );
                      }
                    } else {
                      return ShimmeringWidget(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // body: SafeArea(
      //   child: Padding(
      //     padding: EdgeInsets.all(8),
      //     child: SingleChildScrollView(
      //       physics: BouncingScrollPhysics(),
      //       child: Column(
      //         children: [
      //           AuctionInfoContainer(),
      //           SizedBox(
      //             height: 20,
      //           ),
      //           Text(
      //             'Products',
      //             style: kHeaderTextStyle.copyWith(fontSize: 35),
      //             textAlign: TextAlign.left,
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           TextFormField(
      //             decoration: kSearchFieldDecoration.copyWith(
      //                 hintText: 'Search in Products'),
      //             textInputAction: TextInputAction.search,
      //             style: kSearchFieldTextStyle,
      //             cursorColor: kprimarycolor,
      //             onChanged: (value) {
      //               //TODO: Build search list view
      //             },
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           ListView.separated(
      //               separatorBuilder: (BuildContext context, int index) =>
      //                   const Divider(),
      //               physics: NeverScrollableScrollPhysics(),
      //               scrollDirection: Axis.vertical,
      //               itemCount: 5,
      //               shrinkWrap: true,
      //               itemBuilder: (context, index) {
      //                 return IapProductContainer(
      //                   auctionType: 'Live',
      //                   imageName: 'sampleimage1',
      //                   productName: 'Product 1',
      //                   productDesc: 'Description',
      //                   productTags: ['Electronics', 'Ancient Items', 'Coins'],
      //                   productPriceOrBid: '500000',
      //                 );
      //               }),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
