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
  List<SearchProducts> searchproducts = [];
  TextEditingController _searchFieldController = TextEditingController();

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
            FutureBuilder<AllProductsModel>(
              future: thisproducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Padding(
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
                                controller: _searchFieldController,
                                textInputAction: TextInputAction.search,
                                style: kSearchFieldTextStyle,
                                cursorColor: kprimarycolor,
                                onChanged: (value) {
                                  setState(() {
                                    _searchProduct(value, snapshot);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        content: (_searchFieldController.text.isEmpty)
                            ? ListView.separated(
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
                                    imageName: snapshot
                                        .data!.result[index].productImage,
                                    productName: snapshot
                                        .data!.result[index].productName,
                                    productID:
                                        snapshot.data!.result[index].productId,
                                    productDesc: snapshot
                                        .data!.result[index].productDesc,
                                    productTags: snapshot
                                        .data!.result[index].productCategory
                                        .split('*'),
                                    productPriceOrBid:
                                        snapshot.data!.result[index].basePrice,
                                  );
                                })
                            : _buildSearchListView(),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Products Available',
                        style: kHeaderTextStyle,
                      ),
                    );
                  }
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ShimmeringWidget(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 40),
                      SizedBox(
                        height: 20,
                      ),
                      ShimmeringWidget(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4)
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildSearchListView() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: searchproducts.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return IapProductContainer(
            auctionType: 'Live',
            auctionID: searchproducts[index].auctionId,
            imageName: searchproducts[index].productImage,
            productName: searchproducts[index].productName,
            productID: searchproducts[index].productId,
            productDesc: searchproducts[index].productDesc,
            productTags: searchproducts[index].productTags,
            productPriceOrBid: searchproducts[index].productPriceOrBid,
          );
        });
  }

  void _searchProduct(String query, AsyncSnapshot asyncSnapshot) {
    searchproducts.clear();
    asyncSnapshot.data!.result.forEach((element) {
      print(element.productName.toLowerCase());
      if (element.productName.toLowerCase().contains(query.toLowerCase()) ||
          element.productCategory.contains(query) ||
          element.productDesc.toLowerCase().contains(query.toLowerCase())) {
        searchproducts.add(SearchProducts(
            element.productImage,
            element.auctionId,
            element.productId,
            element.productName,
            element.productDesc,
            'Upcoming',
            element.basePrice,
            element.productCategory.split('*')));
      }
    });
  }
}

class SearchProducts {
  late String productImage,
      auctionId,
      productId,
      productName,
      productDesc,
      auctionType,
      productPriceOrBid;
  late List<String> productTags;

  SearchProducts(
      this.productImage,
      this.auctionId,
      this.productId,
      this.productName,
      this.productDesc,
      this.auctionType,
      this.productPriceOrBid,
      this.productTags);
}
