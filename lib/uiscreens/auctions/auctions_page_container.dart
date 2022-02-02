import 'package:auto_size_text/auto_size_text.dart';
import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class AuctionsPageContainer extends StatelessWidget {
  final String type, imageName, productName, hostName, currentBid, time;

  AuctionsPageContainer(
      {required this.type,
      required this.imageName,
      required this.productName,
      required this.hostName,
      required this.currentBid,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.35,
      // width: MediaQuery.of(context).size.width * 0.45,
      // height: 330,
      width: 180,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 180,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              // image: DecorationImage(
              //   image: AssetImage(
              //     'assets/images/' + imageName + '.jpg',
              //   ),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Image.asset(
              'assets/images/' + imageName + '.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          AutoSizeText(
            productName + '//////////////////////////////////////////',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kprimarycolor,
            ),
            minFontSize: 19,
            maxLines: 1,
            maxFontSize: 22,
            overflow: TextOverflow.ellipsis,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     AutoSizeText(
          //       productName+'//////////////////////////////////////////',
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: kprimarycolor,
          //       ),
          //       minFontSize: 19,
          //       maxLines: 1,
          //       maxFontSize: 22,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //     Container(
          //       padding: EdgeInsets.all(2),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(3),
          //           color: Colors.lightGreen.shade100,
          //           border: Border.all(
          //               color: Colors.green.shade500
          //           )
          //       ),
          //       child: Text(
          //         'Live',
          //         maxLines: 1,
          //         style: TextStyle(
          //           color: Colors.green.shade500,
          //           fontSize: 12,
          //           fontWeight: FontWeight.bold
          //         ),
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Tags:',
            style: TextStyle(fontSize: 12),
          ),
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue.shade800)),
                        child: Text(
                          'Electronics',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.blue.shade800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      )
                    ],
                  );
                }),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                'Host:',
                style: TextStyle(fontSize: 12),
              ),
              Flexible(
                child: AutoSizeText(
                  hostName,
                  minFontSize: 15,
                  maxLines: 1,
                  maxFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kprimarycolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            (type == 'Live') ? 'Current Bid' : 'Base Price',
            style: TextStyle(fontSize: 12),
          ),
          Flexible(
            child: AutoSizeText(
              currentBid,
              minFontSize: 25,
              maxLines: 1,
              maxFontSize: 27,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            (type == 'Live') ? 'Ending In' : 'Scheduled Start',
            style: TextStyle(fontSize: 12),
          ),
          Flexible(
            child: AutoSizeText(
              time,
              textAlign: TextAlign.start,
              minFontSize: 18,
              maxFontSize: 20,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: (type == 'Live') ? Colors.red : Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
