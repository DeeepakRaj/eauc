import 'package:dots_indicator/dots_indicator.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/widgetmodels/header_row.dart';
import 'package:eauc/widgetmodels/see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eauc/uiscreens/home/home_ongoingauctions_container.dart';

class HomeLiveAuctions extends StatefulWidget {
  const HomeLiveAuctions({Key? key}) : super(key: key);

  @override
  _HomeLiveAuctionsState createState() => _HomeLiveAuctionsState();
}

class _HomeLiveAuctionsState extends State<HomeLiveAuctions> {
  late double _currentCarouselIndex = 0;
  CarouselController _buttonCarouselController = CarouselController();
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          HeaderRow(
              headerText: 'Ongoing Auctions',
              onTap: () {
                //TODO: Navigate to Live Auctions tab in Auctions in bottom navigation bar
              }),
          CarouselSlider.builder(
            options: CarouselOptions(
                enlargeCenterPage: true,
                height: screenHeight * 0.35,
                viewportFraction: 1,
                autoPlay: false,
                initialPage: 0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCarouselIndex = index.toDouble();
                  });
                }),
            itemCount: 5,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    GestureDetector(
              onTap: () {
                //TODO: Go to Individual Auction Event Page
              },
              child: HomeOngoingAuctionsContainer(
                'Product 1',
                'Description',
                'Hostname',
                '30000',
                '01:24:28',
              ),
            ),
          ),
          Center(
            child: DotsIndicator(
              dotsCount: 5,
              position: _currentCarouselIndex,
              decorator: DotsDecorator(
                color: Colors.grey, // Inactive color
                activeColor: kprimarycolor,
                activeSize: Size.fromRadius(7),
              ),
            ),
          )
        ],
      ),
    );
  }
}
