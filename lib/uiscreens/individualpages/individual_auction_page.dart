import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/material.dart';

class IndividualAuctionPage extends StatefulWidget {
  static const routename = 'individual_auction_page';

  @override
  _IndividualAuctionPageState createState() => _IndividualAuctionPageState();
}

class _IndividualAuctionPageState extends State<IndividualAuctionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product 1'),
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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Coins Auction',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: kprimarycolor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          'Auction Description Auction Description Auction Description Auction Description Auction Description',
                          style: kCardSubTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Titan Coins Pvt. Ltd',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'titancoins@gmail.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Products',
                  style: kHeaderTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                          ),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/sampleimage1.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                'Product1',
                                                style: kCardTitleTextStyle,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Description',
                                                overflow: TextOverflow.ellipsis,
                                                style: kCardSubTitleTextStyle,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text('Tags:'),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 25,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: 5,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return TagContainer(
                                                          'Electronics');
                                                    }),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      color: Colors.orange,
                                                    ),
                                                    child: Text(
                                                      'CURRENT BID',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '5000',
                                                style: TextStyle(
                                                  color: Colors.orange.shade800,
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: kSmallTextFieldDecoration
                                              .copyWith(
                                            prefixIcon: Icon(
                                              Icons.monetization_on,
                                            ),
                                            hintText: 'Place Bid',
                                            fillColor: kbackgroundcolor,
                                          ),
                                          cursorColor: kprimarycolor,
                                          autofocus: false,
                                          style: kSearchFieldTextStyle,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomNormalButton(
                                          onPressed: () {
                                            //TODO: Update current bid both in database and on screen
                                          },
                                          buttonText: 'Bid',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
