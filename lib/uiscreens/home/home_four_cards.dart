import 'package:flutter/material.dart';
import 'package:eauc/widgetmodels/shaded_container.dart';

class HomeFourCards extends StatelessWidget {
  const HomeFourCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(
                child: ShadedContainer(
                    theTitle: 'Live Auction',
                    theRoute: 'Hi',
                    imgName: 'liveauctions'),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ShadedContainer(
                    theTitle: 'Upcoming Auctions',
                    theRoute: 'Hi',
                    imgName: 'upcomingauctions'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ShadedContainer(
                    theTitle: 'Products', theRoute: 'Hi', imgName: 'products3'),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ShadedContainer(
                    theTitle: 'History', theRoute: 'Hi', imgName: 'history'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
