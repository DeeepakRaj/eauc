import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'auction_info_container.dart';
import 'iap_product_container.dart';

class IndividualAuctionPage extends StatefulWidget {
  static const routename = 'individual_auction_page';

  @override
  _IndividualAuctionPageState createState() => _IndividualAuctionPageState();
}

class _IndividualAuctionPageState extends State<IndividualAuctionPage> {
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
      // body: StickyHeader(
      //   header: TextFormField(
      //     decoration: kSearchFieldDecoration.copyWith(
      //         hintText: 'Search in Products'
      //     ),
      //     textInputAction: TextInputAction.search,
      //     style: kSearchFieldTextStyle,
      //     cursorColor: kprimarycolor,
      //     onChanged: (value){
      //       //TODO: Build search list view
      //     },
      //   ),
      //   content: ,
      // ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                AuctionInfoContainer(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Products',
                  style: kHeaderTextStyle.copyWith(fontSize: 35),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
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
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return IapProductContainer(
                        auctionType: 'Live',
                        imageName: 'sampleimage1',
                        productName: 'Product 1',
                        productDesc: 'Description',
                        productTags: ['Electronics', 'Ancient Items', 'Coins'],
                        productPriceOrBid: '500000',
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}