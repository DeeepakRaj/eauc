import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/auctions/auctions_page_container.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';

class HostedAuctionsPage extends StatefulWidget {
  const HostedAuctionsPage({Key? key}) : super(key: key);

  @override
  _HostedAuctionsPageState createState() => _HostedAuctionsPageState();
}

class _HostedAuctionsPageState extends State<HostedAuctionsPage> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text('Hosted Auctions'),
              pinned: true,
                  floating: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  bottom: TabBar(
                    indicatorColor: kprimarycolor,
                    indicatorWeight: 4,
                    isScrollable: false,
                    labelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    labelColor: kprimarycolor,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'All',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Live',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Upcoming',
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                HostedAuctionsAll(),
                HostedAuctionsLive(),
                HostedAuctionsUpcoming(),
              ],
            ),
          )),
    );
  }
}

class HostedAuctionsAll extends StatefulWidget {
  const HostedAuctionsAll({Key? key}) : super(key: key);

  @override
  _HostedAuctionsAllState createState() => _HostedAuctionsAllState();
}

class _HostedAuctionsAllState extends State<HostedAuctionsAll> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        TextFormField(
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
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                children: List.generate(
                    6,
                    (index) => AuctionsPageContainer(
                      auctionID: '111',
                          auctionName: 'Product1',
                          hostName: 'HostName',
                          auctionDesc: 'auctionDesc',
                          type: 'Live',
                          imageName: 'sampleimage1',
                          time: '13/12/2022 13:23',
                        ))),
          ),
        )
      ],
    );
  }
}

class HostedAuctionsLive extends StatefulWidget {
  const HostedAuctionsLive({Key? key}) : super(key: key);

  @override
  _HostedAuctionsLiveState createState() => _HostedAuctionsLiveState();
}

class _HostedAuctionsLiveState extends State<HostedAuctionsLive> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
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
            child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                children: List.generate(
                    6,
                    (index) => AuctionsPageContainer(
                      auctionID: '111',
                          auctionName: 'Product1',
                          hostName: 'HostName',
                          auctionDesc: 'AuctionDesc',
                          type: 'Live',
                          imageName: 'sampleimage1',
                          time: '13/12/2022 13:23',
                        ))),
          ),
        )
      ],
    );
  }
}

class HostedAuctionsUpcoming extends StatefulWidget {
  const HostedAuctionsUpcoming({Key? key}) : super(key: key);

  @override
  _HostedAuctionsUpcomingState createState() => _HostedAuctionsUpcomingState();
}

class _HostedAuctionsUpcomingState extends State<HostedAuctionsUpcoming> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        TextFormField(
          cursorColor: kprimarycolor,
          style: kSearchFieldTextStyle,
          decoration: kSearchFieldDecoration.copyWith(
            hintText: 'Search in Upcoming Auctions',
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
            child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                direction: Axis.horizontal,
                children: List.generate(
                    6,
                    (index) => AuctionsPageContainer(
                      auctionID: '111',
                          auctionName: 'Product1',
                          hostName: 'HostName',
                          auctionDesc: 'auctionDesc',
                          type: 'Live',
                          imageName: 'sampleimage1',
                          time: '13/12/2022 13:23',
                        ))),
          ),
        )
      ],
    );
  }
}
