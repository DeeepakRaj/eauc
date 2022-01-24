import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/shaded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Home extends StatefulWidget {
  static const routename = '/homepage';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool typing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        titleSpacing: 10,
        backgroundColor: kprimarycolor,
        elevation: 5.0,
        centerTitle: true,
        title: typing
            ? TextBox()
            : Text(
                'HOME',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
        leading: typing
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    typing = !typing;
                  });
                },
              )
            : SizedBox(
                width: 1,
              ),
        actions: [
          typing
              ? SizedBox(
                  width: 1,
                )
              : IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      typing = !typing;
                    });
                  },
                ),
          typing
              ? Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                )
              : SizedBox(
                  width: 5,
                ),
          typing
              ? SizedBox(
                  width: 1,
                )
              : Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              HomeFourCards(),
              // HomeLiveAuctions(),
              // HomeUpcomingAuctions(),
              // HomeProductCategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeFourCards extends StatelessWidget {
  const HomeFourCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ShadedContainer(
                    theTitle: 'Live Auction',
                    theRoute: 'Hi',
                    imgName: 'liveauction2'),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ShadedContainer(
                    theTitle: 'Upcoming Auction',
                    theRoute: 'Hi',
                    imgName: 'liveauction'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ShadedContainer(
                    theTitle: 'Live Auction',
                    theRoute: 'Hi',
                    imgName: 'liveauction'),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ShadedContainer(
                      theTitle: 'Live Auction',
                      theRoute: 'Hi',
                      imgName: 'liveauction')),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeLiveAuctions extends StatefulWidget {
  const HomeLiveAuctions({Key? key}) : super(key: key);

  @override
  _HomeLiveAuctionsState createState() => _HomeLiveAuctionsState();
}

class _HomeLiveAuctionsState extends State<HomeLiveAuctions> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeUpcomingAuctions extends StatefulWidget {
  const HomeUpcomingAuctions({Key? key}) : super(key: key);

  @override
  _HomeUpcomingAuctionsState createState() => _HomeUpcomingAuctionsState();
}

class _HomeUpcomingAuctionsState extends State<HomeUpcomingAuctions> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeProductCategoryList extends StatelessWidget {
  const HomeProductCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          cursorColor: kprimarycolor,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            focusColor: kprimarycolor,
            hoverColor: kprimarycolor,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: kprimarycolor,
            ),
            prefixIconColor: kprimarycolor,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: () {
                //TODO: Clear the search field
              },
            ),
            hintText: 'Search...',
          ),
        ),
      ),
    );
  }
}
