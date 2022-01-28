import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eauc/uiscreens/home/home_ongoingauctions_container.dart';

class HomeLiveAuctions extends StatefulWidget {
  const HomeLiveAuctions({Key? key}) : super(key: key);

  @override
  _HomeLiveAuctionsState createState() => _HomeLiveAuctionsState();
}

class _HomeLiveAuctionsState extends State<HomeLiveAuctions> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ongoing Auctions',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text('See All'),
            ],
          ),
          // HomeOngoingAuctionsContainer(),
          CarouselSlider.builder(
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: screenHeight * 0.35,
              viewportFraction: 1,
              autoPlay: false,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
            itemCount: 5,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    HomeOngoingAuctionsContainer(),
          )
        ],
      ),
    );
  }
}
