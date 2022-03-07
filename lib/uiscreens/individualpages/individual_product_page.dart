import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/individualpages/auction_info_container.dart';
import 'package:eauc/uiscreens/products/products_page_container.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/material.dart';

class IndividualProductPage extends StatefulWidget {
  const IndividualProductPage({Key? key}) : super(key: key);

  @override
  _IndividualProductPageState createState() => _IndividualProductPageState();
}

class _IndividualProductPageState extends State<IndividualProductPage> {
  late double _currentCarouselIndex = 0;
  CarouselController carouselController = CarouselController();
  final featuredImages = [
    'assets/images/sampleimage1.jpg',
    'assets/images/sampleimage2.jpg',
  ];

  bool _showBottomSheet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Product Name'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: kbackgroundcolor,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      height: MediaQuery.of(context).size.height * 0.40,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index.toDouble();
                        });
                      }),
                  items: featuredImages.map((featuredImage) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            featuredImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                DotsIndicator(
                  dotsCount: featuredImages.length,
                  position: _currentCarouselIndex,
                  decorator: DotsDecorator(
                    color: Colors.grey.shade300, // Inactive color
                    activeColor: Colors.white,
                    activeSize: Size.fromRadius(7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            // padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          AuctionInfoContainer(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomNormalButton(
                                              buttonText: 'Go to Auction',
                                              onPressed: () {})
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Coins AuctionCoins AuctionCoins AuctionCoins Auction',
                                    style: kCardTitleTextStyle.copyWith(
                                        color: ksecondarycolor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'DescriptionDescriptionDescriptionDescriptionDescription',
                                        overflow: TextOverflow.ellipsis,
                                        style: kCardSubTitleTextStyle.copyWith(
                                            fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'more',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ksecondarycolor,
                                          decoration: TextDecoration.underline),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.orange.withOpacity(0.1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Ending In: ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '12:14:15',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 8,
            color: Colors.transparent,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ksecondarycolor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                    child: Text(
                      'Current Bid',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '400000',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: kbackgroundcolor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: Center(
                                    child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: kprimarycolor,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                '500',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: kbackgroundcolor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Center(
                                    child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: kprimarycolor,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomNormalButton(
                      buttonText: 'PLACE BID',
                      onPressed: () {
                        // TODO: Change current bid in the database
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: kCardTitleTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 30,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return TagContainer('Ancient');
                      }),
                ),
                Divider(
                  height: 20,
                ),
                Text(
                  'About this item',
                  style: kHeaderTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Description',
                  maxLines: 6,
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          Divider(
            height: 30,
            color: Colors.transparent,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'More products in this auction',
              style: kHeaderTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: double.infinity,
              height: kProductsListViewHeight,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ProductsPageContainer(
                      productName: 'Product Name',
                      imageName: 'sampleimage1',
                      hostName: 'HostName',
                      currentBid: '50000',
                      type: 'Live',
                      time: '12:14:15',
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: ElevatedButton(
            child: Text("Close Bottom Sheet"),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.green,
            ),
            onPressed: () {
              _showBottomSheet = false;
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
