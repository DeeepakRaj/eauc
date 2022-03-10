import 'package:eauc/uiscreens/profile/history_page.dart';
import 'package:eauc/uiscreens/profile/hosted_auctions_page.dart';
import 'package:eauc/uiscreens/profile/my_account_page.dart';
import 'package:eauc/uiscreens/profile/pinned_auctions_page.dart';
import 'package:eauc/widgetmodels/custom_navigation_drawer.dart';
import 'package:eauc/widgetmodels/shaded_container.dart';
import 'package:eauc/widgetmodels/shaded_container2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Profile extends StatefulWidget {
  static const routename = '/hostedpage';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
      ),
      drawer: CustomNavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                child: Image.asset(
                  'assets/images/myprofile.jpg',
                  width: double.infinity,
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.40,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyAccountPage()),
                      );
                    },
                    child: ShadedContainer2(
                      theTitle: 'My Account',
                      cardColor: Colors.white,
                      textColor: Colors.white,
                      imgName: 'usericon',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PinnedAuctionsPage()),
                      );
                    },
                    child: ShadedContainer2(
                        theTitle: 'Pinned Auctions',
                        cardColor: Colors.white,
                        textColor: Colors.white,
                        imgName: 'pinicon'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HostedAuctionsPage()),
                      );
                    },
                    child: ShadedContainer2(
                        theTitle: 'Hosted Auctions',
                        cardColor: Colors.white,
                        textColor: Colors.white,
                        imgName: 'auctionicon'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoryPage()),
                      );
                    },
                    child: ShadedContainer2(
                        theTitle: 'History',
                        cardColor: Colors.white,
                        textColor: Colors.white,
                        imgName: 'historyicon'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
