import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/search_results_page.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:flutter/material.dart';

class AdvancedFilter extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  AdvancedFilter({required this.screenWidth, required this.screenHeight});

  @override
  _AdvancedFilterState createState() => _AdvancedFilterState();
}

class _AdvancedFilterState extends State<AdvancedFilter> {
  final GlobalKey<FormState> _advFilterFormKey = GlobalKey<FormState>();
  List<String> auctionTypes = ['All', 'Live', 'Upcoming'];
  String? _auctiontype,
      _keyword,
      _hostname,
      _productcategory,
      _basepricefrom,
      _basepriceto;
  DateTime? _datefrom, _dateto;

  @override
  void initState() {
    super.initState();
    _auctiontype = auctionTypes[0];
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
                key: _advFilterFormKey,
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
                      decoration: kSmallTextFieldDecoration.copyWith(
                          hintText: 'Type Search Keyword'),
                      style: kSearchFieldTextStyle,
                      cursorColor: kprimarycolor,
                      onChanged: (value) {
                        _keyword = value;
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
                      decoration: kSmallTextFieldDecoration.copyWith(
                          hintText: 'Type Hostname'),
                      style: kSearchFieldTextStyle,
                      cursorColor: kprimarycolor,
                      onChanged: (value) {
                        _hostname = value;
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
                            decoration: kSmallTextFieldDecoration,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Product Category:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DropdownSearch<String>(
                      mode: Mode.DIALOG,
                      items: [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      //TODO: Customize this whole widget
                      dropdownSearchDecoration:
                          kSmallTextFieldDecoration.copyWith(
                        hintText: 'Select Product Category',
                        hintStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(color: Colors.black),
                      ),
                      popupBackgroundColor: kbackgroundcolor,
                      showClearButton: true,
                      showSearchBox: true,
                      showSelectedItems: true,
                      popupShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      dropdownSearchBaseStyle: TextStyle(color: Colors.black),
                      selectionListViewProps: SelectionListViewProps(
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics()),
                      searchFieldProps: TextFieldProps(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Enter Category',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: kprimarycolor, width: 3)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: kprimarycolor, width: 3)),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                          )),
                      // popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: print,
                      selectedItem: null,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Base Price Range:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: TextFormField(
                            decoration: kSmallTextFieldDecoration.copyWith(
                                hintText: ''),
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: false,
                            ),
                            style: kSearchFieldTextStyle,
                            cursorColor: kprimarycolor,
                            validator: (value) {
                              if (_basepricefrom == null ||
                                  _basepricefrom!.isEmpty) {
                                if (_basepriceto != null ||
                                    _basepriceto!.isNotEmpty)
                                  return 'Please leave either both fields blank or none';
                              } else if (!RegExp(numberRegExp)
                                  .hasMatch(_basepricefrom!))
                                return 'Please enter a valid number';
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _basepricefrom = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            'To',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Flexible(
                          child: TextFormField(
                            decoration: kSmallTextFieldDecoration.copyWith(
                                hintText: ''),
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: false,
                              signed: false,
                            ),
                            style: kSearchFieldTextStyle,
                            cursorColor: kprimarycolor,
                            validator: (value) {
                              if (_basepriceto == null ||
                                  _basepriceto!.isEmpty) {
                                if (_basepricefrom != null ||
                                    _basepricefrom!.isNotEmpty)
                                  return 'Please leave either both fields blank or none';
                              } else if (!RegExp(numberRegExp)
                                  .hasMatch(_basepriceto!))
                                return 'Please enter a valid number';
                              else if (int.parse(_basepriceto!) <
                                  int.parse(_basepricefrom!))
                                return 'Invalid Range';
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _basepriceto = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Dates:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
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
                      decoration: kSmallTextFieldDecoration.copyWith(
                        hintText: 'From',
                      ),
                      style: TextStyle(color: Colors.black),
                      type: DateTimePickerType.dateTime,
                      dateMask: 'dd-MM-yyyy HH:mm',
                      initialValue: DateTime.now().toString(),
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
                      decoration: kSmallTextFieldDecoration.copyWith(
                        hintText: 'From',
                      ),
                      style: TextStyle(color: Colors.black),
                      type: DateTimePickerType.dateTime,
                      dateMask: 'dd-MM-yyyy HH:mm',
                      initialValue:
                          DateTime.now().add(Duration(minutes: 5)).toString(),
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            // if(!_advFilterFormKey.currentState!.validate())
            //   return;
            // else{
            //   //TODO: Navigate to the Search Results Screen by horizontal sliding animation
            // }
            Navigator.pushNamed(context, SearchResultsPage.routename);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(15.0),
            backgroundColor: knormalbuttoncolor,
            primary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide.none),
            textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          child: Text(
            'Search',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
