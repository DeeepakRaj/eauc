import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:flutter/material.dart';

class IppBiddingContainer extends StatefulWidget {
  final String productId;

  IppBiddingContainer({required this.productId});

  @override
  _IppBiddingContainerState createState() => _IppBiddingContainerState();
}

class _IppBiddingContainerState extends State<IppBiddingContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
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
    );
  }
}
