import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/individualpages/individual_product_page.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/tag_container.dart';
import 'package:flutter/material.dart';

class IapProductContainer extends StatefulWidget {
  final String imageName,
      productName,
      productDesc,
      auctionType,
      productPriceOrBid;
  final List<String> productTags;

  IapProductContainer(
      {required this.auctionType,
      required this.imageName,
      required this.productName,
      required this.productDesc,
      required this.productTags,
      required this.productPriceOrBid});

  @override
  _IapProductContainerState createState() => _IapProductContainerState();
}

class _IapProductContainerState extends State<IapProductContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IndividualProductPage()),
        );
      },
      child: Container(
        color: Colors.white,
        width: double.infinity,
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
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/${widget.imageName}.jpg',
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.productName,
                              style: kCardTitleTextStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.productDesc,
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
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: widget.productTags.length,
                                  itemBuilder: (context, index) {
                                    return TagContainer(
                                        widget.productTags[index]);
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
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.orange,
                                  ),
                                  child: Text(
                                    'CURRENT BID',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
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
                              widget.productPriceOrBid,
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
                        decoration: kSmallInputFieldDecoration.copyWith(
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
      ),
    );
  }
}
