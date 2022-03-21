import 'dart:convert';

import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/registration_page.dart';
import 'package:eauc/uiscreens/wrapper.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  static const routename = '/loginpage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginPageFormKey = GlobalKey<FormState>();
  late bool obscurePwdText;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    obscurePwdText = true;
    getIdPreference().then((value) async {
      if (value != 'No Email Attached') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Wrapper()),
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: kprimarycolor,
        strokeWidth: 5,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Center(child: Text('LOGIN')),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _loginPageFormKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/loginpageimg2.jpg',
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 25.0,
                              color: kblacktextcolor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'eAuc',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                            color: kprimarycolor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: kInputFieldDecoration.copyWith(
                                hintText: 'Email'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is Required';
                              }
                              if (!RegExp(emailRegExp).hasMatch(value)) {
                                return 'Enter a valid Email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //TODO: Store the value in a variable
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _pwdController,
                            obscureText: obscurePwdText,
                            decoration: kInputFieldDecoration.copyWith(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePwdText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePwdText = !obscurePwdText;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is Required';
                              }
                              if (!RegExp(passwordRegExp).hasMatch(value)) {
                                return 'Enter a valid Password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              //TODO: Store the value in a variable
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Forgot Password?',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextButton(
                            onPressed: () {
                              if (!_loginPageFormKey.currentState!.validate()) {
                                return;
                              } else {
                                _loginButtonPressed();
                              }
                            },
                            buttonText: 'LOGIN'),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              RegistrationPage.routename,
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            'SIGN UP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: kprimarycolor,
                                fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginButtonPressed() async {
    var url = apiUrl + "signin.php";
    setState(() {
      _loading = true;
    });
    var response = await http.post(Uri.parse(url), body: {
      "email": _emailController.text,
      "pwd": _pwdController.text,
    });
    var data = jsonDecode(response.body);
    if (data == 'account not exist') {
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
        msg: 'Account Does Not Exist. Please Create Account',
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.of(context).pushNamedAndRemoveUntil(
        RegistrationPage.routename,
        (Route<dynamic> route) => false,
      );
    } else {
      if (data == 'true') {
        savedIdPreference(_emailController.text).then(
          (bool committed) {
            setState(() {
              _loading = false;
              Fluttertoast.showToast(
                msg: 'Logged In Successfully',
                toastLength: Toast.LENGTH_LONG,
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                Wrapper.routename,
                (Route<dynamic> route) => false,
              );
            });
          },
        );
      } else {
        setState(() {
          _loading = false;
        });
        Fluttertoast.showToast(
          msg: 'Error. Please Try Again',
          toastLength: Toast.LENGTH_LONG,
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          LoginPage.routename,
          (Route<dynamic> route) => false,
        );
      }
    }
  }
}
