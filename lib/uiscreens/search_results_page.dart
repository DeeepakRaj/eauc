import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/auctions/auctions_page_container.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';

class SearchResultsPage extends StatefulWidget {
  static const routename = 'searchresultspage';

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
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
      appBar: AppBar(
          title: Text('Search Results'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Results Found: 78',
                  style: kHeaderTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 180 / 290,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: kProductsListViewHeight,
                      child: AuctionsPageContainer(
                        auctionID: '111',
                        auctionName: 'Product1',
                        hostName: 'HostName',
                        auctionDesc: 'auctionDesc',
                        type: 'Live',
                        imageName: 'sampleimage1',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
