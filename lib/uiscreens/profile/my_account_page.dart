import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/databasemodels/UserModel.dart';
import 'package:eauc/uiscreens/profile/edit_account_page.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/shimmering_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final GlobalKey<FormState> _myaccountformkey = GlobalKey<FormState>();
  late String emailid;
  Future<UserModel>? thisuser;

  Future<UserModel> getUserData(String emailid) async {
    var user;
    var url = apiUrl + "getUserData.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": emailid,
    });
    print(response.statusCode);
    user = userFromJson(response.body);
    return user;
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
          thisuser = getUserData(emailid);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<UserModel>(
      future: thisuser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return CustomScrollView(
              physics: ScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  backgroundColor: kprimarycolor,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [StretchMode.fadeTitle],
                    title: Text(
                      snapshot.data!.email,
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.2,
                    background:
                        Image.asset('assets/images/myaccount_bgphoto.jpg'),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAccountPage(
                                        email: snapshot.data!.email,
                                        firstname: snapshot.data!.firstname,
                                        lastname: snapshot.data!.lastname,
                                        city: snapshot.data!.city,
                                        country: snapshot.data!.country,
                                        state: snapshot.data!.states,
                                        address: snapshot.data!.addr,
                                        pincode: snapshot.data!.pincode,
                                        mobile: snapshot.data!.contact,
                                      ))).then((_) {
                            setState(() {
                              thisuser = getUserData(emailid);
                            });
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ))
                  ],
                  expandedHeight: MediaQuery.of(context).size.height * 0.35,
                ),
                SliverFillRemaining(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'MY ACCOUNT',
                        style: kCardTitleTextStyle,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            color: kbackgroundcolor,
                            shape:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            child: ListTile(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              leading: Image.asset(
                                'assets/images/myaccount_user.jpg',
                                height: 35,
                                width: 35,
                              ),
                              title: Text(
                                'NAME',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                              subtitle: Text(
                                '${snapshot.data!.firstname} ${snapshot.data!.lastname}',
                                style: kCardTitleTextStyle.copyWith(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            color: kbackgroundcolor,
                            shape:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            child: ListTile(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              leading: Image.asset(
                                'assets/images/myaccount_phone.jpg',
                                height: 35,
                                width: 35,
                              ),
                              title: Text(
                                'CONTACT',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                              subtitle: Text(
                                snapshot.data!.contact,
                                style: kCardTitleTextStyle.copyWith(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            color: kbackgroundcolor,
                            shape:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            child: ListTile(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              leading: Image.asset(
                                'assets/images/myaccount_email.jpg',
                                height: 35,
                                width: 35,
                              ),
                              title: Text(
                                'EMAIL',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                              subtitle: Text(
                                snapshot.data!.email,
                                style: kCardTitleTextStyle.copyWith(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            color: kbackgroundcolor,
                            shape:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            child: ListTile(
                              shape: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              leading: Image.asset(
                                'assets/images/myaccount_address.jpg',
                                height: 35,
                                width: 35,
                              ),
                              title: Text(
                                'ADDRESS',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                              subtitle: Text(
                                '${snapshot.data!.addr}, ${snapshot.data!.city}-${snapshot.data!.pincode}, ${snapshot.data!.states}, ${snapshot.data!.country}',
                                style: kCardTitleTextStyle.copyWith(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.10),
                            child: Divider(
                              height: 30,
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                              vertical: 5,
                            ),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05,
                                  vertical: 5),
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return CustomScrollView(
              physics: ScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  backgroundColor: kprimarycolor,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [StretchMode.fadeTitle],
                    title: Text(
                      'No Data Available',
                      style: kHeaderTextStyle.copyWith(color: Colors.white),
                    ),
                    centerTitle: true,
                    expandedTitleScale: 1.2,
                    background:
                        Image.asset('assets/images/myaccount_bgphoto.jpg'),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * 0.35,
                ),
                SliverFillRemaining(
                    child: Center(
                  child: Text(
                    'No Data Available',
                    style: kHeaderTextStyle,
                  ),
                ))
              ],
            );
          }
        } else {
          return CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: kprimarycolor,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [StretchMode.fadeTitle],
                  title: ShimmeringWidget(
                    width: 240,
                    height: 20,
                  ),
                  centerTitle: true,
                  expandedTitleScale: 1.2,
                  background:
                      Image.asset('assets/images/myaccount_bgphoto.jpg'),
                ),
                centerTitle: true,
                leading: IconButton(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
              ),
              SliverFillRemaining(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'MY ACCOUNT',
                      style: kCardTitleTextStyle,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShimmeringWidget(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.10),
                          child: Divider(
                            height: 30,
                            thickness: 2,
                          ),
                        ),
                        ShimmeringWidget(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        }
      },
    ));
  }
}
