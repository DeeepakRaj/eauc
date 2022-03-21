import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/createauction/add_product_page.dart';
import 'package:eauc/uiscreens/createauction/product_class.dart';
import 'package:eauc/uiscreens/individualpages/individual_auction_page.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_product_page.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({Key? key}) : super(key: key);

  @override
  _CreateAuctionPageState createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage> {
  DateTime? _datefrom, _dateto;
  late Product addedProduct;
  List<Product> products = [];
  String emailid = "";

  TextEditingController _auctionName = TextEditingController();
  TextEditingController _auctionDescription = TextEditingController();

  @override
  void dispose() {
    _auctionName.dispose();
    _auctionDescription.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getIdPreference().then((String id){
      setState(() {
        this.emailid = id;
      });
    });
  }

  void _createAuction() async {
    var url = apiUrl + "createAuction.php";

    var auctionData = Map<String, dynamic>();

    auctionData["auction_name"] = _auctionName.text;
    auctionData["auction_desc"] = _auctionDescription.text;
    auctionData["start_Date"] = _datefrom.toString();
    auctionData["end_Date"] = _dateto.toString();
    auctionData["email"] = emailid;
    auctionData["products_length"] = products.length.toString();


    for (var i = 0; i < products.length; i++) {
       auctionData['productName'+(i).toString()] = products[i].productName;
       auctionData['productDesc'+(i).toString()] = products[i].productDesc;
       auctionData['productPrice'+(i).toString()] = products[i].productPrice.toString();
       auctionData['productTags'+(i).toString()] = products[i].productTags.join(",").toString();
       auctionData['productImage'+(i).toString()] = base64Encode(products[i].primaryImage.readAsBytesSync());

       var images = [];

       for (var j = 0; j < products[i].moreImages.length; j++) {
         images.add(base64Encode(products[i].moreImages[j].readAsBytesSync()));
       }

       auctionData['moreProductImages'+(i).toString()] = images.join(",").toString();
    }

    var response = await http.post(Uri.parse(url), body: auctionData);

    var data = jsonDecode(response.body);
    //print(data);
    if (data == "true") {
      Fluttertoast.showToast(msg: "Auction Hosted Successfully",toastLength: Toast.LENGTH_LONG);
    }
    else {
      Fluttertoast.showToast(msg: "Auction Hosted Unsuccessfully",toastLength: Toast.LENGTH_LONG);
    }

    //print(response.statusCode);

  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    try {
      addedProduct = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddProductPage()),
      );
      setState(() {
        products.add(addedProduct);
      });
    } catch (e) {
      print(e);
    }
  }

  void _editProduct(BuildContext context, Product product, int index) async {
    try {
      addedProduct = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProductPage(
                  product: product,
                )),
      );
      setState(() {
        products.removeAt(index);
        products.insert(index, addedProduct);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Auction'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: CustomTextButton(
              onPressed: (products.length == 0)
                  ? null
                  : () {
                      //TODO: Create Auction into Database
                  _createAuction();
                    },
              buttonText: 'CREATE'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Auction Details',
                    style: kHeaderTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: kInputFieldDecoration.copyWith(
                      hintText: 'Auction Name',
                    ),
                    style: kInputFieldTextStyle,
                    cursorColor: kprimarycolor,
                    onChanged: (value) {},
                    controller: _auctionName,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: kInputFieldDecoration.copyWith(
                      hintText: 'Auction Description',
                    ),
                    maxLines: 4,
                    style: kInputFieldTextStyle,
                    cursorColor: kprimarycolor,
                    onChanged: (value) {},
                    controller: _auctionDescription,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Auction Duration',
                    style: kHeaderTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'From:',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DateTimePicker(
                    decoration: kInputFieldDecoration.copyWith(
                      hintText: 'From',
                    ),
                    style: TextStyle(color: Colors.black),
                    type: DateTimePickerType.dateTime,
                    dateMask: 'dd-MM-yyyy HH:mm',
                    initialValue: '',
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: 'Hour',
                    onChanged: (val) {
                      _datefrom = DateTime.parse(val);
                    },
                    validator: (val) {
                      if (_datefrom == null || _datefrom.toString().isEmpty) {
                        if (_dateto != null || _dateto!.toString().isNotEmpty)
                          return 'Please leave either both fields blank or none';
                      }
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'To:',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DateTimePicker(
                    decoration: kInputFieldDecoration.copyWith(
                      hintText: 'To',
                    ),
                    style: TextStyle(color: Colors.black),
                    type: DateTimePickerType.dateTime,
                    dateMask: 'dd-MM-yyyy HH:mm',
                    initialValue: '',
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: 'Hour',
                    onChanged: (val) {
                      _dateto = DateTime.parse(val);
                    },
                    validator: (val) {
                      if (_dateto == null || _dateto.toString().isEmpty) {
                        if (_datefrom != null ||
                            _datefrom!.toString().isNotEmpty)
                          return 'Please leave either both fields blank or none';
                      } else if (_datefrom!.isAfter(_dateto!))
                        return 'Please enter a valid range';
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Products',
                    style: kHeaderTextStyle,
                  ),
                  (products.isNotEmpty)
                      ? ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(products[index].productName),
                              background: slideRightBackground(),
                              secondaryBackground: slideLeftBackground(),
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.endToStart) {
                                  return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text(
                                            "Are you sure you want to delete this product?",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                // TODO: Delete the item from DB etc..
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  products.removeAt(index);
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  _editProduct(context, products[index], index);
                                }
                              },
                              onDismissed: (direction) {
                                setState(() {
                                  products.removeAt(index);
                                });
                              },
                              child: ListTile(
                                tileColor: Colors.white,
                                style: ListTileStyle.list,
                                // shape: RoundedRectangleBorder(
                                //     side: BorderSide(
                                //         color: Colors.grey,
                                //         width: 2
                                //     ),
                                //     borderRadius: BorderRadius.all(Radius.circular(10))
                                // ),
                                isThreeLine: true,
                                leading: Text(
                                  '${index + 1}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                title: Text(
                                  products[index].productName,
                                  style: kCardTitleTextStyle,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(products[index].productDesc),
                                    Text(
                                      products[index].productPrice,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                          ),
                          itemCount: products.length,
                        )
                      : SizedBox(
                          height: 5,
                        ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Click on + to add products',
                          style: kCardSubTitleTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigateAndDisplaySelection(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: kprimarycolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
