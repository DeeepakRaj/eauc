import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eauc/constants.dart';
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
          // DraggableScrollableSheet(
          //     initialChildSize: 0.5,
          //     minChildSize: 0.5,
          //     snap: true,
          //     builder: (_, scrollController) {
          //       return Container(
          //         padding: EdgeInsets.all(15),
          //         decoration: BoxDecoration(
          //           borderRadius:
          //           BorderRadius.vertical(top: Radius.circular(30)),
          //           color: Colors.white,
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey,
          //               offset: Offset(0.0, 1.0), //(x,y)
          //               blurRadius: 10.0,
          //             ),
          //           ],
          //         ),
          //         child: ListView(
          //           controller: scrollController,
          //           children: [
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //             Text(
          //               'Product Name',
          //               style: kCardTitleTextStyle,
          //             ),
          //           ],
          //         ),
          //       );
          //     }),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Name',
                                style: kCardTitleTextStyle,
                              ),
                              Container(
                                height: 30,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return TagContainer('Electronics');
                                    }),
                              ),
                            ],
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
            color: Colors.transparent,
            thickness: 2,
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/bid_icon.jpg',
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.pink),
                            child: Text(
                              'CURRENT BID',
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '#400000',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 3,
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: kbackgroundcolor,
                                            // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
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
                                              fontSize: 30,
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
                                            // borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomNormalButton(
                          buttonText: 'BID',
                          onPressed: () {
                            //TODO: Increase bid
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
