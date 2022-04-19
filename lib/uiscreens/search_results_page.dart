import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/AuctionModel.dart';
import 'package:eauc/databasemodels/auction_advanced_filter_model.dart';
import 'package:eauc/uiscreens/auctions/auctions_page_container.dart';
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:http/http.dart' as http;

class SearchResultsAuctions extends StatefulWidget {
  static const routename = 'searchresultspage';
  final String auctionType, keyWord, hostName, dateFrom, dateTo;

  SearchResultsAuctions(
      {required this.auctionType,
      required this.keyWord,
      required this.hostName,
      required this.dateFrom,
      required this.dateTo});

  @override
  _SearchResultsAuctionsState createState() => _SearchResultsAuctionsState();
}

class _SearchResultsAuctionsState extends State<SearchResultsAuctions> {
  late String emailid;
  Future<AuctionAdvancedFilterModel>? auctionsearchresults;

  Future<AuctionAdvancedFilterModel> getAuctionSearchResults() async {
    print(widget.dateFrom);
    print(widget.dateTo);
    var auctions;
    var url = apiUrl + "AuctionData/getAuctionAdvancedFilterData.php";
    var response = await http.post(Uri.parse(url), body: {
      "keyword": widget.keyWord,
      "hostname": widget.hostName,
      "type": widget.auctionType,
      "start_date_from": widget.dateFrom,
      "start_date_to": widget.dateTo
    });
    auctions = auctionAdvancedFilterModelFromJson(response.body);
    return auctions;
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
          auctionsearchresults = getAuctionSearchResults();
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
          child: FutureBuilder<AuctionAdvancedFilterModel>(
            future: auctionsearchresults,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Results Found: ' +
                              snapshot.data!.result.length.toString(),
                          style: kHeaderTextStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: kAuctionsListViewWidth /
                                kAuctionsListViewHeight,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.result.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: kAuctionsListViewHeight,
                              child: AuctionsPageContainer(
                                auctionID:
                                    snapshot.data!.result[index].auctionId,
                                auctionName:
                                    snapshot.data!.result[index].auctionName,
                                hostName: snapshot.data!.result[index].email,
                                auctionDesc:
                                    snapshot.data!.result[index].auctionDesc,
                                type: 'Live',
                                imageName: 'sampleimage1',
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'No Results Found',
                      style: kHeaderTextStyle,
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SearchResultsProducts extends StatefulWidget {
  const SearchResultsProducts({Key? key}) : super(key: key);

  @override
  _SearchResultsProductsState createState() => _SearchResultsProductsState();
}

class _SearchResultsProductsState extends State<SearchResultsProducts> {
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
    return Container();
  }
}
