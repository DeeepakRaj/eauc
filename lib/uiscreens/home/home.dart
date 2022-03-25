import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:eauc/widgetmodels/display_auction_countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ntp/ntp.dart';
import 'home_four_cards.dart';
import 'home_live_auctions.dart';
import 'home_product_category_list.dart';
import 'home_upcoming_auctions.dart';

class Home extends StatefulWidget {
  static const routename = '/homepage';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool typing = false;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      drawer: CustomNavigationDrawer(),
      appBar: AppBar(
        title: typing
            ? TextBox()
            : DisplayAuctionCountdown(
                auctionId: '110',
              ),
        leading: typing
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: kprimarycolor,
                ),
                onPressed: () {
                  setState(() {
                    typing = !typing;
                  });
                },
              )
            : null,
        actions: [
          typing
              ? SizedBox(
                  width: 1,
                )
              : IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: kprimarycolor,
                  ),
                  onPressed: () {
                    setState(() {
                      typing = !typing;
                    });
                  },
                ),
          typing
              ? Icon(
            Icons.filter_alt_outlined,
                  size: 30,
                  color: kprimarycolor,
                )
              : SizedBox(
                  width: 5,
                ),
          typing
              ? SizedBox(
                  width: 1,
                )
              : Icon(
                  Icons.settings,
                  size: 30,
                  color: kprimarycolor,
                ),
        ],
      ),
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                HomeFourCards(),
                SizedBox(
                  height: 30,
                ),
                HomeLiveAuctions(),
                SizedBox(
                  height: 30,
                ),
                HomeUpcomingAuctions(),
                // HomeProductCategoryList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          cursorColor: kprimarycolor,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusColor: kprimarycolor,
            hoverColor: kprimarycolor,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: kprimarycolor,
            ),
            prefixIconColor: kprimarycolor,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: () {
                //TODO: Clear the search field
              },
            ),
            hintText: 'Search...',
          ),
        ),
      ),
    );
  }
}
