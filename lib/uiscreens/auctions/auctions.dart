import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class Auctions extends StatefulWidget {
  static const routename = '/auctionspage';

  @override
  _AuctionsState createState() => _AuctionsState();
}

class _AuctionsState extends State<Auctions> {
  late String popupSelectedValue = '';
  List<String> popUpMenuValues = ['All', 'Live', 'Upcoming'];

  @override
  void initState() {
    super.initState();
    popupSelectedValue = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              switch (result) {
                case 'All':
                  {
                    print('filter 1 clicked');
                    setState(() {
                      popupSelectedValue = popUpMenuValues[0];
                    });
                    break;
                  }
                case 'Live':
                  {
                    print('filter 2 clicked');
                    setState(() {
                      popupSelectedValue = popUpMenuValues[1];
                    });
                    break;
                  }
                case 'Upcoming':
                  {
                    print('Clear filters');
                    setState(() {
                      popupSelectedValue = popUpMenuValues[2];
                    });
                    break;
                  }
                default:
                  {
                    setState(() {
                      popupSelectedValue = popUpMenuValues[0];
                    });
                    break;
                  }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: popUpMenuValues[0],
                child: Text(
                  popUpMenuValues[0],
                  style: TextStyle(
                      color: (popupSelectedValue == popUpMenuValues[0])
                          ? kprimarycolor
                          : Colors.black,
                      fontWeight: (popupSelectedValue == popUpMenuValues[0])
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
              PopupMenuItem<String>(
                value: popUpMenuValues[1],
                child: Text(
                  popUpMenuValues[1],
                  style: TextStyle(
                      color: (popupSelectedValue == popUpMenuValues[1])
                          ? kprimarycolor
                          : Colors.black,
                      fontWeight: (popupSelectedValue == popUpMenuValues[1])
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
              PopupMenuItem<String>(
                value: popUpMenuValues[2],
                child: Text(
                  popUpMenuValues[2],
                  style: TextStyle(
                      color: (popupSelectedValue == popUpMenuValues[2])
                          ? kprimarycolor
                          : Colors.black,
                      fontWeight: (popupSelectedValue == popUpMenuValues[2])
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text('Auctions Page'),
          ),
        ),
      ),
    );
  }
}
