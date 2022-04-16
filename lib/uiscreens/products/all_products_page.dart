import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AllProductsModel.dart';
import 'package:eauc/uiscreens/advanced_filter_product.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/products/expandable_categories_container.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({Key? key}) : super(key: key);

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
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
        });
        thisproducts = getAuctionProducts('all');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: FutureBuilder<AllProductsModel>(
        future: thisproducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  ExpandableCategoriesContainer(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ending Recently',
                    style: kHeaderTextStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    height: kProductsListViewHeight,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.result.length,
                        itemBuilder: (context, index) {
                          return ProductsPageContainer(
                            productID: snapshot.data!.result[index].productId,
                            auctionID: snapshot.data!.result[index].auctionId,
                            productName:
                                snapshot.data!.result[index].productName,
                            imageName:
                                snapshot.data!.result[index].productImage,
                            hostName: snapshot.data!.result[index].host_email,
                            productTags:
                                snapshot.data!.result[index].productCategory,
                            currentBid: snapshot.data!.result[index].basePrice,
                            type: 'Live',
                            time: '12:14:15',
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //TODO: Uncomment below lines and add other filters
                  // Text(
                  //   'Live Auctions',
                  //   style: kHeaderTextStyle,
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //   width: double.infinity,
                  //   height: kProductsListViewHeight,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       shrinkWrap: true,
                  //       itemCount: snapshot.data!.result.length,
                  //       itemBuilder: (context, index) {
                  //         return ProductsPageContainer(
                  //           productID: snapshot.data!.result[index].productId,
                  //           auctionID: snapshot.data!.result[index].auctionId,
                  //           productName: snapshot.data!.result[index].productName,
                  //           imageName: snapshot.data!.result[index].productImage,
                  //           hostName: snapshot.data!.result[index].email,
                  //           productTags: snapshot.data!.result[index].productCategory,
                  //           currentBid: snapshot.data!.result[index].basePrice,
                  //           type: 'Live',
                  //           time: '12:14:15',
                  //         );
                  //       }),
                  // ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'No Data Available',
                  style: kHeaderTextStyle,
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
