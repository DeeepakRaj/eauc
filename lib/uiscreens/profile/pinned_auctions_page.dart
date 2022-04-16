import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/pinned_auctions_model.dart';
import 'package:eauc/uiscreens/auctions/auctions_page_container.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eauc/uiscreens/login_page.dart';

class PinnedAuctionsPage extends StatefulWidget {
  static const routename = '/pinnedauctionspage';

  @override
  _PinnedAuctionsPageState createState() => _PinnedAuctionsPageState();
}

class _PinnedAuctionsPageState extends State<PinnedAuctionsPage> {
  late String emailid;
  Future<PinnedAuctionModel>? pinnedauctions;

  Future<PinnedAuctionModel> getPinnedAuctions(String email) async {
    var pauction;
    var url = apiUrl + "AuctionData/getPinnedAuctions.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": email,
    });
    pauction = pinnedAuctionModelFromJson(response.body);
    return pauction;
  }

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
        pinnedauctions = getPinnedAuctions(emailid);
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
          child: FutureBuilder<PinnedAuctionModel>(
            future: pinnedauctions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
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
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.result.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio:
                                      200 / kAuctionsListViewHeight,
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return AuctionsPageContainer(
                              auctionID: snapshot.data!.result[index].auctionId,
                              auctionName:
                                  snapshot.data!.result[index].auctionName,
                              hostName: snapshot.data!.result[index].email,
                              auctionDesc:
                                  snapshot.data!.result[index].auctionDesc,
                              type: snapshot.data!.result[index].type,
                              imageName: 'sampleimage1',
                            );
                          },
                        ),
                      ),
                      // Expanded(
                      //   child: SingleChildScrollView(
                      //     child: Wrap(
                      //         alignment: WrapAlignment.spaceEvenly,
                      //         direction: Axis.horizontal,
                      //         children: List.generate(6,
                      //                 (index) => AuctionsPageContainer(
                      //                   auctionID: '111',
                      //                   auctionName: 'Product1',
                      //                   hostName: 'HostName',
                      //                   auctionDesc: 'auctionDesc',
                      //                   type: 'Live',
                      //                   imageName: 'sampleimage1',
                      //                   time: '13/12/2022 13:23',
                      //                 ))),
                      //   ),
                      // )
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      'No Pinned Auctions',
                      style: kHeaderTextStyle,
                    ),
                  );
                }
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ShimmeringWidget(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 4,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 200 / kAuctionsListViewHeight,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return ShimmeringWidget(
                              width: 200, height: kAuctionsListViewHeight);
                        },
                      ),
                    ),
                  ],
                );
                ;
              }
            },
          ),
        ),
      ),
    );
  }
}
