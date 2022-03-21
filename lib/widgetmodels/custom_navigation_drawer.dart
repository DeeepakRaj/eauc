import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  _CustomNavigationDrawerState createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  late String emailid;
  bool _loading = false;

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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        strokeWidth: 5,
        color: kprimarycolor,
      ),
      child: Drawer(
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
              onTap: () async {
                setState(() {
                  _loading = true;
                });
                try {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  setState(() {
                    Fluttertoast.showToast(
                        msg: 'Logged Out Successfully',
                        toastLength: Toast.LENGTH_LONG);
                    _loading = false;
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.routename, (route) => false);
                  });
                } catch (e) {
                  setState(() {
                    Fluttertoast.showToast(
                        msg: 'Error. Please Try Again',
                        toastLength: Toast.LENGTH_LONG);
                    _loading = false;
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
