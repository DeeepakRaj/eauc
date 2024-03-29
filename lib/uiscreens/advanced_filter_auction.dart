import 'package:date_time_picker/date_time_picker.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/search_results_page.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'login_page.dart';

class AdvancedFilterAuction extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  AdvancedFilterAuction(
      {required this.screenWidth, required this.screenHeight});

  @override
  _AdvancedFilterAuctionState createState() => _AdvancedFilterAuctionState();
}

class _AdvancedFilterAuctionState extends State<AdvancedFilterAuction> {
  final GlobalKey<FormState> _advFilterAuctionFormKey = GlobalKey<FormState>();
  late String emailid;
  List<String> auctionTypes = ['All', 'Live', 'Upcoming'];
  String? _auctiontype, _keyword, _hostname;
  DateTime? _datefrom, _dateto;

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
    _auctiontype = auctionTypes[0];
    _keyword = '';
    _hostname = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(15),
      contentPadding: EdgeInsets.all(15),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: kbackgroundcolor,
      scrollable: true,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: Text(
        'Advanced Filter',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 25,
          color: kprimarycolor,
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
            height: widget.screenHeight * 0.60,
            width: widget.screenWidth * 0.90,
            color: kbackgroundcolor,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _advFilterAuctionFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Search Keyword:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: kSmallInputFieldDecoration.copyWith(
                          hintText: 'Type Search Keyword'),
                      style: kSearchFieldTextStyle,
                      cursorColor: kprimarycolor,
                      onChanged: (value) {
                        setState(() {
                          _keyword = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'HostName:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: kSmallInputFieldDecoration.copyWith(
                          hintText: 'Type Hostname'),
                      style: kSearchFieldTextStyle,
                      cursorColor: kprimarycolor,
                      onChanged: (value) {
                        setState(() {
                          _hostname = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Type of Auctions:',
                            style: TextStyle(
                                color: kprimarycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: DropdownButtonFormField(
                            style: kSearchFieldTextStyle,
                            items: auctionTypes.map((String type) {
                              return new DropdownMenuItem(
                                  value: type, child: Text(type));
                            }).toList(),
                            onChanged: (newValue) {
                              // do other stuff with _category
                              setState(
                                  () => _auctiontype = newValue.toString());
                            },
                            value: _auctiontype,
                            decoration: kSmallInputFieldDecoration,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (_auctiontype == 'Live')
                        ? SizedBox(
                            height: 5,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Dates:',
                                  style: TextStyle(
                                      color: kprimarycolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                                decoration: kSmallInputFieldDecoration.copyWith(
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
                                  print(_datefrom == null);
                                  if ((_datefrom == null ||
                                          _datefrom.toString().isEmpty) &&
                                      (_dateto == null ||
                                          _dateto.toString().isEmpty)) {
                                    return null;
                                  } else if ((_dateto != null &&
                                          _dateto.toString().isNotEmpty) &&
                                      (_datefrom != null &&
                                          _datefrom.toString().isNotEmpty)) {
                                    return null;
                                  } else
                                    return 'Please leave either both fields blank or none';
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
                                decoration: kSmallInputFieldDecoration.copyWith(
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
                                  setState(() {
                                    _dateto = DateTime.parse(val);
                                  });
                                },
                                validator: (val) {
                                  if ((_dateto == null ||
                                          _dateto.toString().isEmpty) &&
                                      (_datefrom == null ||
                                          _datefrom.toString().isEmpty)) {
                                    return null;
                                  } else if ((_dateto != null &&
                                          _dateto.toString().isNotEmpty) &&
                                      (_datefrom != null &&
                                          _datefrom.toString().isNotEmpty)) {
                                    if (_datefrom!.isAfter(_dateto!))
                                      return 'Please enter a valid range';
                                    else
                                      return null;
                                  } else
                                    return 'Please leave either both fields empty or none';
                                },
                                onSaved: (val) => print(val),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        CustomNormalButton(
          onPressed: () {
            if (!_advFilterAuctionFormKey.currentState!.validate()) {
              return;
            } else {
              print(_hostname == null);
              //TODO: Navigate to the Search Results Screen by horizontal sliding animation
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchResultsAuctions(
                            auctionType: _auctiontype!,
                            hostName: (_hostname == null) ? '' : _hostname!,
                            keyWord: (_keyword == null) ? '' : _keyword!,
                            dateFrom: (_datefrom == null)
                                ? ''
                                : _datefrom!.millisecondsSinceEpoch.toString(),
                            dateTo: (_dateto == null)
                                ? ''
                                : _dateto!.millisecondsSinceEpoch.toString(),
                          )));
            }
          },
          buttonText: 'Search',
        ),
      ],
    );
  }
}
