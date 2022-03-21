import 'package:carousel_slider/carousel_slider.dart';
import 'package:eauc/database/db.dart';
import 'package:flutter/material.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/login_page.dart';

class HomeUpcomingAuctionsContainer extends StatefulWidget {
  const HomeUpcomingAuctionsContainer({Key? key}) : super(key: key);

  @override
  _HomeUpcomingAuctionsContainerState createState() =>
      _HomeUpcomingAuctionsContainerState();
}

class _HomeUpcomingAuctionsContainerState
    extends State<HomeUpcomingAuctionsContainer> {
  CarouselController carouselController = CarouselController();
  final featuredImages = [
    'assets/images/sampleimage1.jpg',
    'assets/images/sampleimage2.jpg',
  ];
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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        //TODO: Navigate to Individual Auction page
      },
      child: Container(
        // height: screenHeight / 3,
        width: screenWidth,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      child: CarouselSlider(
                        carouselController: carouselController,
                        // Give the controller
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                        items: featuredImages.map((featuredImage) {
                          return Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
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
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          // Use the controller to change the current page
                          carouselController.previousPage();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: kprimarycolor,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          // Use the controller to change the current page
                          carouselController.nextPage();
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: kprimarycolor,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product 1//////////////////////////////////////////////',
                          style: kCardTitleTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Flexible(
                            child: Text('Description',
                                style: kCardSubTitleTextStyle)),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Host:',
                                style: kCardSubTitleTextStyle,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Host Name',
                                style: kCardSubTitleTextStyle,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            'Starting Price',
                            style: TextStyle(
                                fontSize: 13,
                                color: kprimarycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '5000',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Scheduled Start:  ',
                        style: TextStyle(
                            color: kprimarycolor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '22-09-2022 16:00',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
