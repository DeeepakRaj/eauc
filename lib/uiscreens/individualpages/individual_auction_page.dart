import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:http/http.dart' as http;

import 'auction_info_container.dart';
import 'iap_product_container.dart';

class IndividualAuctionPage extends StatefulWidget {
  static const routename = 'individual_auction_page';
  final String auctionID;

  IndividualAuctionPage({required this.auctionID});

  @override
  _IndividualAuctionPageState createState() => _IndividualAuctionPageState();
}

class _IndividualAuctionPageState extends State<IndividualAuctionPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Coins Auction'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<AuctionModel>(
        future: thisauction,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            print(snapshot.hasData);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  AuctionInfoContainer(
                    auctionID: widget.auctionID,
                    place: 'individualauctionplace',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: StickyHeader(
                      header: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                      content: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.products.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return IapProductContainer(
                              auctionType: 'Live',
                              imageName: 'sampleimage1',
                              productName:
                                  snapshot.data!.products[index].productName,
                              productDesc:
                                  snapshot.data!.products[index].productDesc,
                              productTags: snapshot
                                  .data!.products[index].productCategory
                                  .split(','),
                              productPriceOrBid:
                                  snapshot.data!.products[index].basePrice,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            );
          }
        },
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
