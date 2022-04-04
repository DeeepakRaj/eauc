import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/advanced_filter.dart';
import 'package:eauc/uiscreens/products/expandable_categories_container.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:flutter/material.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  _MyProductsPageState createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ProductsPageContainer(
                    productID: 'productId',
                    auctionID: 'auctionid',
                    productName: 'Product Name',
                    imageName: 'sampleimage1',
                    hostName: 'HostName',
                    productTags: 'Tags',
                    currentBid: '50000',
                    type: 'Live',
                    time: '12:14:15',
                  );
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Live Auctions',
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ProductsPageContainer(
                    productID: 'productID',
                    auctionID: 'auctionID',
                    productName: 'Product Name',
                    imageName: 'sampleimage1',
                    hostName: 'HostName',
                    currentBid: '50000',
                    productTags: 'Tags',
                    type: 'Upcoming',
                    time: '12:14:15',
                  );
                }),
          ),
        ],
      ),
    );
  }
}
