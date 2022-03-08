import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/advanced_filter.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'expandable_categories_container.dart';

class Products extends StatefulWidget {
  static const routename = '/productspage';

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late String _popupSelectedValue = '';
  List<String> _popUpMenuValues = ['All', 'My Products'];

  @override
  void initState() {
    super.initState();
    _popupSelectedValue = _popUpMenuValues[0];
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUCTS'),
        actions: [
          PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 6,
            icon: Icon(Icons.filter_list),
            onSelected: (String result) {
              _popupSelectedValue = result;
            },
            itemBuilder: (BuildContext context) {
              return List.generate(
                _popUpMenuValues.length,
                (index) => PopupMenuItem<String>(
                  value: _popUpMenuValues[index],
                  child: Text(
                    _popUpMenuValues[index],
                    style: TextStyle(
                        color: (_popupSelectedValue == _popUpMenuValues[index])
                            ? kprimarycolor
                            : Colors.black,
                        fontWeight:
                            (_popupSelectedValue == _popUpMenuValues[index])
                                ? FontWeight.bold
                                : FontWeight.normal),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
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
                          productName: 'Product Name',
                          imageName: 'sampleimage1',
                          hostName: 'HostName',
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
                          productName: 'Product Name',
                          imageName: 'sampleimage1',
                          hostName: 'HostName',
                          currentBid: '50000',
                          type: 'Upcoming',
                          time: '12:14:15',
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
