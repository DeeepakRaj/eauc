import 'package:eauc/uiscreens/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();
    obscurePwdText = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _loginPageFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            'Welcome to',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 40.0,
                                color: kblacktextcolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'eAuc',
                            style: TextStyle(
                              fontSize: 57.0,
                              fontWeight: FontWeight.w900,
                              color: kprimarycolor,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15.0,
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: kTextInputDecoration.copyWith(
                                hintText: 'Email'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21.0,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is Required';
                              }
                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
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
                            decoration: kTextInputDecoration.copyWith(
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
                            style: TextStyle(fontSize: 17.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: TextButton(
                          onPressed: () {
                            //TODO: Sign up and go to home screen
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(25.0),
                            backgroundColor: knormalbuttoncolor,
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide.none),
                            textStyle: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900),
                          ),
                          child: Text(
                            'LOGIN',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                          child: GestureDetector(
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
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
