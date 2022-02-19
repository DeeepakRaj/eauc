import 'package:date_time_picker/date_time_picker.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/createauction/create_product_page.dart';
import 'package:eauc/uiscreens/createauction/product_class.dart';
import 'package:eauc/uiscreens/individualpages/individual_auction_page.dart';
import 'package:flutter/material.dart';

class CreateAuctionPage extends StatefulWidget {
  const CreateAuctionPage({Key? key}) : super(key: key);

  @override
  _CreateAuctionPageState createState() => _CreateAuctionPageState();
}

class _CreateAuctionPageState extends State<CreateAuctionPage> {
  DateTime? _datefrom, _dateto;
  late Product addedProduct;
  List<Product> products = [];

  void _navigateAndDisplaySelection(BuildContext context) async {
    try {
      addedProduct = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CreateProductPage()),
      );
      setState(() {
        products.add(addedProduct);
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create ',
                        style: TextStyle(fontSize: 50, color: Colors.black),
                      ),
                      Text(
                        'Auction',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                          color: kprimarycolor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                                  // TODO: Navigate to edit page;
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
                                      '500000',
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
                          style: kCardSubTitleTextStyle.copyWith(fontSize: 20),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigateAndDisplaySelection(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: kbackgroundcolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 60,
                              color: kprimarycolor,
                            ),
                          ),
                        )
                      ],
                    ),
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
