import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/home/home.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/createauction/add_product_page.dart';
import 'package:eauc/uiscreens/createauction/product_class.dart';
import 'package:eauc/uiscreens/individualpages/individual_auction_page.dart';
import 'package:eauc/uiscreens/wrapper.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/custom_outlined_button.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  late String emailid;
  bool _loading = false;

  // final collectionRef = FirebaseFirestore.instance;
  // final dbBatch = FirebaseFirestore.instance.batch;

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

  WriteBatch _insertIntoFirestore(auctionId, List productIds) {
    final collectionRef = FirebaseFirestore.instance;
    final batch = FirebaseFirestore.instance.batch();
    DocumentReference docRef;
    productIds.forEach((id) {
      docRef =
          collectionRef.collection(auctionId.toString()).doc(id.toString());
      batch.set(docRef, {
        "basePrice": products[productIds.indexOf(id)].productPrice.toString(),
        "timeRemaining": "12:43:12",
      });
    });
    return batch;
  }

  void _createAuction() async {
    var url = apiUrl + "createAuction.php";
    setState(() {
      _loading = true;
    });
    var auctionData = Map<String, dynamic>();

    auctionData["auction_name"] = _auctionName.text;
    auctionData["auction_desc"] = _auctionDescription.text;
    auctionData["start_Date"] = _datefrom.toString();
    auctionData["end_Date"] = _dateto.toString();
    auctionData["email"] = emailid;
    auctionData["products_length"] = products.length.toString();

    for (var i = 0; i < products.length; i++) {
      auctionData['productName' + (i).toString()] = products[i].productName;
      auctionData['productDesc' + (i).toString()] = products[i].productDesc;
      auctionData['productPrice' + (i).toString()] =
          products[i].productPrice.toString();
      auctionData['productTags' + (i).toString()] =
          products[i].productTags.join(",").toString();
      auctionData['productImage' + (i).toString()] =
          (base64Encode(products[i].primaryImage.readAsBytesSync())).toString();

      var images = [];
      for (int j = 0; j < products[i].moreImages.length; j++) {
        images.add((base64Encode(products[i].moreImages[j].readAsBytesSync()))
            .toString());
      }
      auctionData['moreProductImages' + (i).toString()] =
          images.join(",").toString();
    }

    try {
      var response = await http.post(Uri.parse(url), body: auctionData);
      var data = jsonDecode(response.body);
      if (data['result'] == "true") {
        _insertIntoFirestore(data['auction_id'], data['products_id'])
            .commit()
            .then((value) {
          setState(() {
            _loading = false;
          });
          Fluttertoast.showToast(
              msg: "Auction Created Successfully",
              toastLength: Toast.LENGTH_LONG);
          _showCongratulationsDialog();
        }).catchError((error) async {
          url = apiUrl + "deleteAuction.php";
          var response = await http.post(Uri.parse(url), body: auctionData);
          data = jsonDecode(response.body);
          if (data['result'] == 'success') {
            setState(() {
              _loading = false;
            });
            Fluttertoast.showToast(
                msg: "Error. Please Try Again", toastLength: Toast.LENGTH_LONG);
          } else {
            //TODO: Think about what to do in this
          }
        });
      } else {
        setState(() {
          _loading = false;
        });
        Fluttertoast.showToast(
            msg: "Error. Please Try Again", toastLength: Toast.LENGTH_LONG);
      }
    } catch (exception) {
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: "Error. Please Try Again", toastLength: Toast.LENGTH_LONG);
    }
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

  void _showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: kbackgroundcolor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            title: Text(
              'Are you sure?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: kprimarycolor,
              ),
            ),
            content: Text(
              'Are you sure you want to exit Create Auction Page? Any data entered in this page will be lost.',
              textAlign: TextAlign.justify,
              style: kHeaderTextStyle.copyWith(color: Colors.red),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: kprimarycolor),
                ),
              ),
              CustomNormalButton(
                  buttonText: 'Yes, Exit This Page',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  void _showCongratulationsDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: kbackgroundcolor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            title: Text(
              'CONGRATULATIONS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: kprimarycolor,
              ),
            ),
            content: Text(
              'You have successfully created an auction event. You can check your '
              'created/hosted auctions under Hosted Auctions in Profile tab',
              textAlign: TextAlign.justify,
              style: kHeaderTextStyle.copyWith(color: Colors.green),
            ),
            actions: [
              CustomNormalButton(
                  buttonText: 'OK',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Wrapper()),
                        (route) => false);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: kprimarycolor,
        strokeWidth: 3,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Create Auction'),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                _showConfirmationDialog();
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: CustomTextButton(
                onPressed: (products.length == 0)
                    ? null
                    : () {
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
                        setState(() {
                          _datefrom = DateTime.parse(val);
                        });
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
                      readOnly:
                          _datefrom == null || _datefrom.toString().isEmpty,
                      initialValue: '',
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      timeLabelText: 'Hour',
                      onChanged: (val) {
                        setState(() {
                          _dateto = DateTime.parse(val);
                        });
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
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                              "Are you sure you want to delete this product?",
                                              style: TextStyle(
                                                  color: Colors.black),
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
                                    _editProduct(
                                        context, products[index], index);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
          )),
    );
  }
}
