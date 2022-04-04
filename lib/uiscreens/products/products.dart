import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/advanced_filter.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/products/all_products_page.dart';
import 'package:eauc/uiscreens/products/my_products_page.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:eauc/uiscreens/products/shimmering_products.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'expandable_categories_container.dart';

class Products extends StatefulWidget {
  static const routename = '/productspage';

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late String _popupSelectedValue = '';
  List<String> _popUpMenuValues = ['All', 'My Products'];
  late String emailid;

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
      }
    });
    _popupSelectedValue = _popUpMenuValues[0];
  }

  Widget _buildProductsPage() {
    if (_popupSelectedValue == _popUpMenuValues[0])
      return AllProductsPage();
    else
      return MyProductsPage();
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
          child: _buildProductsPage(),
        ),
      ),
    );
  }
}
