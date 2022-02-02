import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/header_row.dart';
import 'package:eauc/widgetmodels/see_all_button.dart';
import 'package:flutter/material.dart';

import 'home_upcomingauctions_container.dart';

class HomeUpcomingAuctions extends StatefulWidget {
  const HomeUpcomingAuctions({Key? key}) : super(key: key);

  @override
  _HomeUpcomingAuctionsState createState() => _HomeUpcomingAuctionsState();
}

class _HomeUpcomingAuctionsState extends State<HomeUpcomingAuctions> {
  late double _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          HeaderRow(
              headerText: 'Upcoming Auctions',
              onTap: () {
                //TODO: Go to Upcoming Auctions tab in auctions in bottom navigation bar
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
                //TODO: Go to Upcoming auctions individual page
              },
              child: HomeUpcomingAuctionsContainer(),
            ),
          ),
          // Stack(
          //   alignment: AlignmentDirectional.centerStart,
          //   children: [
          //     Align(
          //       alignment: Alignment.centerRight,
          //       child: ElevatedButton(
          //         onPressed: () {},
          //         child: Icon(Icons.arrow_forward_ios, color: Colors.white),
          //         style: ElevatedButton.styleFrom(
          //           shape: CircleBorder(),
          //           padding: EdgeInsets.all(10),
          //           primary: Colors.grey, // <-- Button color
          //           // onPrimary: Colors.red, // <-- Splash color
          //         ),
          //       ),
          //     )
          //   ],
          // ),
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
