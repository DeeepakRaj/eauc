import 'package:eauc/constants.dart';
import 'package:eauc/uiscreens/auctions/all_auctions_page.dart';
import 'package:eauc/uiscreens/auctions/live_auctions_page.dart';
import 'package:eauc/uiscreens/auctions/my_hosted_auctions_page.dart';
import 'package:eauc/uiscreens/auctions/upcoming_auctions_page.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class Auctions extends StatefulWidget {
  static const routename = '/auctionspage';

  @override
  _AuctionsState createState() => _AuctionsState();
}

class _AuctionsState extends State<Auctions> {
  late String _popupSelectedValue = '';
  List<String> _popUpMenuValues = ['All', 'Live', 'Upcoming', 'My Hosted'];

  @override
  void initState() {
    super.initState();
    _popupSelectedValue = _popUpMenuValues[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('AUCTIONS'),
        actions: [
          PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 6,
            icon: Icon(Icons.filter_list),
            onSelected: (String result) {
              _popupSelectedValue = result;
            },
            itemBuilder: (BuildContext context) {
              return List.generate(
                _popUpMenuValues.length,
                (index) => PopupMenuItem<String>(
                  value: _popUpMenuValues[index],
                  child: Text(
                    _popUpMenuValues[index],
                    style: TextStyle(
                        color: (_popupSelectedValue == _popUpMenuValues[index])
                            ? kprimarycolor
                            : Colors.black,
                        fontWeight:
                            (_popupSelectedValue == _popUpMenuValues[index])
                                ? FontWeight.bold
                                : FontWeight.normal),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: buildAuctionsPage(),
        ),
      ),
    );
  }

  Widget buildAuctionsPage() {
    if (_popupSelectedValue == _popUpMenuValues[0])
      return AllAuctionsPage();
    else if (_popupSelectedValue == _popUpMenuValues[1])
      return LiveAuctionsPage();
    else if (_popupSelectedValue == _popUpMenuValues[2])
      return UpcomingAuctionsPage();
    else
      return MyHostedAuctionsPage();
  }
}
