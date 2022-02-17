import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/header_row.dart';
import 'package:flutter/material.dart';

import 'auctions_page_container.dart';

class LiveAuctionsPage extends StatefulWidget {
  const LiveAuctionsPage({Key? key}) : super(key: key);

  @override
  _LiveAuctionsPageState createState() => _LiveAuctionsPageState();
}

class _LiveAuctionsPageState extends State<LiveAuctionsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          cursorColor: kprimarycolor,
          style: kSearchFieldTextStyle,
          decoration: kSearchFieldDecoration.copyWith(
            hintText: 'Search in Live Auctions',
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
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeaderRow(
                    headerText: 'Ongoing Auctions',
                    onTap: () {
                      //TODO: Navigate to All Ongoing Auctions Page perhaps
                    }),
                Container(
                  height: 310,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return AuctionsPageContainer(
                          auctionName: 'Product1',
                          hostName: 'HostName',
                          currentBid: '5000',
                          type: 'Live',
                          imageName: 'sampleimage1',
                          time: '13/12/2022 13:23',
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                HeaderRow(
                    headerText: 'Upcoming Auctions',
                    onTap: () {
                      //TODO: Navigate to All Ongoing Auctions Page perhaps
                    }),
                Container(
                  height: 310,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return AuctionsPageContainer(
                          auctionName: 'Product1',
                          hostName: 'HostName',
                          currentBid: '5000',
                          type: 'Upcoming',
                          imageName: 'sampleimage1',
                          time: '13/12/2022 13:23',
                        );
                      }),
                ),
                // AuctionsPageContainer(
                //   productName: 'Product1',
                //   hostName: 'HostName',
                //   currentBid: '5000',
                //   type: 'Live',
                //   imageName: 'sampleimage1',
                //   time: '13:23:05',
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
