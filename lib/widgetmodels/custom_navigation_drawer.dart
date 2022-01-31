import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  _CustomNavigationDrawerState createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: kprimarycolor,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'My Profile',
              style: TextStyle(color: kprimarycolor),
            ),
            leading: Icon(
              Icons.person,
              color: kprimarycolor,
            ),
            onTap: () {
              //TODO: Navigate to profile page
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'History',
              style: TextStyle(color: kprimarycolor),
            ),
            leading: Icon(
              Icons.history,
              color: kprimarycolor,
            ),
            onTap: () {
              //TODO: Navigate to history page
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(color: kprimarycolor),
            ),
            leading: Icon(
              Icons.logout,
              color: kprimarycolor,
            ),
            onTap: () {
              //TODO: Logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
