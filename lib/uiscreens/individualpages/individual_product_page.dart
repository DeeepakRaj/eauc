import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eauc/constants.dart';
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
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: Stack(
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
                      height: MediaQuery.of(context).size.height * 0.50,
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
                          fit: BoxFit.contain,
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
          DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              builder: (_, scrollController) {
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                      Text(
                        'Product Name',
                        style: kCardTitleTextStyle,
                      ),
                    ],
                  ),
                );
              }),
          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsets.all(10),
          //   color: Colors.white,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Text(
          //         'Product Name',
          //         style: kCardTitleTextStyle,
          //       ),
          //       Container(
          //         height: 30,
          //         child: ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemCount: 5,
          //             itemBuilder: (context, index) {
          //               return TagContainer('Electronics');
          //             }),
          //       ),
          //       Divider(),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Flexible(
          //             child: Column(
          //               children: [
          //                 Container(
          //                   padding: EdgeInsets.all(4),
          //                   decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(3),
          //                     color: Colors.orange,
          //                   ),
          //                   child: Text(
          //                     'CURRENT BID',
          //                     maxLines: 1,
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.bold),
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 5,
          //                 ),
          //                 Text(
          //                   '40000',
          //                   style: TextStyle(
          //                     color: Colors.orange.shade800,
          //                     fontSize: 27,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Flexible(
          //             child: ListTile(
          //               leading: Icon(
          //                 Icons.access_time,
          //                 color: Colors.cyan,
          //                 size: 40,
          //               ),
          //               title: Text(
          //                 'Ending In: ',
          //                 style: kCardSubTitleTextStyle.copyWith(
          //                     color: Colors.brown,
          //                   fontWeight: FontWeight.bold
          //                 ),
          //               ),
          //               subtitle: Text(
          //                 '12:14:15',
          //                 style: TextStyle(
          //                   color: Colors.red,
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.bold
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
