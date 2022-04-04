import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/auctions/auctions_page_container.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class PinnedAuctionsPage extends StatefulWidget {
  static const routename = '/pinnedauctionspage';

  @override
  _PinnedAuctionsPageState createState() => _PinnedAuctionsPageState();
}

class _PinnedAuctionsPageState extends State<PinnedAuctionsPage> {
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
        title: Text('My Pinned Auctions'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TextFormField(
                cursorColor: kprimarycolor,
                style: kSearchFieldTextStyle,
                decoration: kSearchFieldDecoration.copyWith(
                  hintText: 'Search in Pinned Auctions',
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
          ),
        ),
      ),
    );
  }
}
