import 'package:eauc/constants.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/shaded_container2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final GlobalKey<FormState> _myaccountformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: ScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          floating: true,
          backgroundColor: kprimarycolor,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [StretchMode.fadeTitle],
            title: Text(
              'themadtitan@gmail.com',
            ),
            centerTitle: true,
            expandedTitleScale: 1.2,
            background: Image.asset('assets/images/myaccount_bgphoto.jpg'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    color: kbackgroundcolor,
                    shape: OutlineInputBorder(borderSide: BorderSide.none),
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
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
                                  'Edit Name',
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
                                      color: kbackgroundcolor,
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Form(
                                          key: _myaccountformkey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'First Name:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    kSmallInputFieldDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Enter First Name'),
                                                style: kSearchFieldTextStyle,
                                                cursorColor: kprimarycolor,
                                                validator: (value) {
                                                  if (value!.isEmpty)
                                                    return 'First Name must not be empty';
                                                },
                                                onChanged: (value) {},
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'Last Name:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    kSmallInputFieldDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Enter Last Name'),
                                                style: kSearchFieldTextStyle,
                                                cursorColor: kprimarycolor,
                                                validator: (value) {
                                                  if (value!.isEmpty)
                                                    return 'Last Name must not be empty';
                                                },
                                                onChanged: (value) {},
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
                                      // if(!_advFilterFormKey.currentState!.validate())
                                      //   return;
                                      // else{
                                      //   //TODO: Navigate to the Search Results Screen by horizontal sliding animation
                                      // }
                                    },
                                    buttonText: 'EDIT',
                                  ),
                                ],
                              );
                            });
                      },
                      shape: OutlineInputBorder(borderSide: BorderSide.none),
                      leading: Image.asset(
                        'assets/images/myaccount_user.jpg',
                        height: 35,
                        width: 35,
                      ),
                      title: Text(
                        'NAME',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      subtitle: Text(
                        'TheMadTitan',
                        style: kCardTitleTextStyle.copyWith(
                            color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    color: kbackgroundcolor,
                    shape: OutlineInputBorder(borderSide: BorderSide.none),
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
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
                                  'Edit Contact',
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
                                      color: kbackgroundcolor,
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Form(
                                          key: _myaccountformkey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'Contact:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.phone,
                                                maxLength: 10,
                                                decoration:
                                                    kInputFieldDecoration
                                                        .copyWith(
                                                            hintText: 'Mobile'),
                                                style: kInputFieldTextStyle,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Mobile Number is Required';
                                                  }
                                                  if (!RegExp(r"[0-9]{10}?")
                                                      .hasMatch(value)) {
                                                    return 'Enter a valid mobile number';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  //TODO: Store the value in a variable
                                                },
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
                                      // if(!_advFilterFormKey.currentState!.validate())
                                      //   return;
                                      // else{
                                      //   //TODO: Navigate to the Search Results Screen by horizontal sliding animation
                                      // }
                                    },
                                    buttonText: 'EDIT',
                                  ),
                                ],
                              );
                            });
                      },
                      shape: OutlineInputBorder(borderSide: BorderSide.none),
                      leading: Image.asset(
                        'assets/images/myaccount_phone.jpg',
                        height: 35,
                        width: 35,
                      ),
                      title: Text(
                        'CONTACT',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      subtitle: Text(
                        '9988776655',
                        style: kCardTitleTextStyle.copyWith(
                            color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    color: kbackgroundcolor,
                    shape: OutlineInputBorder(borderSide: BorderSide.none),
                    child: ListTile(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: 'Email cannot be edited',
                            toastLength: Toast.LENGTH_SHORT);
                      },
                      shape: OutlineInputBorder(borderSide: BorderSide.none),
                      leading: Image.asset(
                        'assets/images/myaccount_email.jpg',
                        height: 35,
                        width: 35,
                      ),
                      title: Text(
                        'EMAIL',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      subtitle: Text(
                        'themadtitan@gmail.com',
                        style: kCardTitleTextStyle.copyWith(
                            color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    color: kbackgroundcolor,
                    shape: OutlineInputBorder(borderSide: BorderSide.none),
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
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
                                  'Edit Address',
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
                                      color: kbackgroundcolor,
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Form(
                                          key: _myaccountformkey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'Address:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    kSmallInputFieldDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Enter Address'),
                                                style: kSearchFieldTextStyle,
                                                maxLines: 3,
                                                cursorColor: kprimarycolor,
                                                validator: (value) {
                                                  if (value!.isEmpty)
                                                    return 'Address must not be empty';
                                                  return null;
                                                },
                                                onChanged: (value) {},
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'Country:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    kSmallInputFieldDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Enter Country'),
                                                style: kSearchFieldTextStyle,
                                                cursorColor: kprimarycolor,
                                                validator: (value) {
                                                  if (value!.isEmpty)
                                                    return 'Country must not be empty';
                                                  return null;
                                                },
                                                onChanged: (value) {},
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'State:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    kSmallInputFieldDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Enter State'),
                                                style: kSearchFieldTextStyle,
                                                cursorColor: kprimarycolor,
                                                validator: (value) {
                                                  if (value!.isEmpty)
                                                    return 'State must not be empty';
                                                  return null;
                                                },
                                                onChanged: (value) {},
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'City:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    kSmallInputFieldDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Enter City'),
                                                style: kSearchFieldTextStyle,
                                                cursorColor: kprimarycolor,
                                                validator: (value) {
                                                  if (value!.isEmpty)
                                                    return 'City must not be empty';
                                                  return null;
                                                },
                                                onChanged: (value) {},
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  'Pincode:',
                                                  style: TextStyle(
                                                      color: kprimarycolor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    kSmallInputFieldDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Pincode Country'),
                                                style: kSearchFieldTextStyle,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                cursorColor: kprimarycolor,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'PinCode is Required';
                                                  }
                                                  if (!RegExp(r"[0-9]{6}?")
                                                      .hasMatch(value)) {
                                                    return 'Enter a valid pincode';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {},
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
                                      // if(!_advFilterFormKey.currentState!.validate())
                                      //   return;
                                      // else{
                                      //   //TODO: Navigate to the Search Results Screen by horizontal sliding animation
                                      // }
                                    },
                                    buttonText: 'EDIT',
                                  ),
                                ],
                              );
                            });
                      },
                      shape: OutlineInputBorder(borderSide: BorderSide.none),
                      leading: Image.asset(
                        'assets/images/myaccount_address.jpg',
                        height: 35,
                        width: 35,
                      ),
                      title: Text(
                        'ADDRESS',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      subtitle: Text(
                        '12, ghennbdb djsnnn jdjjj, jsjnnanm, rhnnnd, indijnma',
                        style: kCardTitleTextStyle.copyWith(
                            color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.10),
                    child: Divider(
                      height: 30,
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
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
                          horizontal: MediaQuery.of(context).size.width * 0.05,
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
    ));
  }
}
