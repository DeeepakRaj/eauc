import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class HomeOngoingAuctionsContainer extends StatefulWidget {
  const HomeOngoingAuctionsContainer({Key? key}) : super(key: key);

  @override
  _HomeOngoingAuctionsContainerState createState() =>
      _HomeOngoingAuctionsContainerState();
}

class _HomeOngoingAuctionsContainerState
    extends State<HomeOngoingAuctionsContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: Navigate to Individual Auction page
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
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
            Flexible(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/' + 'liveauction2' + '.jpg',
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                            Text('Product 1', style: kCardTitleTextStyle),
                            Text('Description', style: kCardSubTitleTextStyle),
                            Row(
                              children: [
                                Text(
                                  'Host:',
                                  style: kCardSubTitleTextStyle,
                                ),
                                Text(
                                  'Host Name',
                                  style: kCardSubTitleTextStyle,
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
                            Text(
                              'Current Bid',
                              style: TextStyle(
                                fontSize: 18,
                                color: kprimarycolor,
                              ),
                            ),
                            Text(
                              '5000000',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ends In:',
                        style: TextStyle(color: kprimarycolor, fontSize: 18),
                      ),
                      Text(
                        '01:14:28',
                        style: TextStyle(color: Colors.red, fontSize: 19),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
