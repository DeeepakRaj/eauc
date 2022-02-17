import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:eauc/uiscreens/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/db.dart';
import '../constants.dart';

class RegistrationPage extends StatefulWidget {
  static const routename = '/registrationpage';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _regPageFormKey = GlobalKey<FormState>();
  late bool obscurePwdText, obscureCPwdText;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _cpwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obscurePwdText = true;
    obscureCPwdText = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _pwdController.dispose();
    _cpwdController.dispose();
    super.dispose();
  }

  void _signUpButtonPressed() {
    //TODO: Implement signup
    // DB().insertIntoDatabase(
    //     _emailController.text,
    //     _pwdController.text,
    //     _firstnameController.text,
    //     _lastnameController.text,
    //     _mobileController.text,
    //     _addressController.text,
    //     _cityController.text,
    //     _pincodeController.text,
    //     _stateController.text,
    //     _countryController.text);
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routename,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _regPageFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Register to',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 40.0,
                        color: kblacktextcolor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'eAuc',
                    style: TextStyle(
                      fontSize: 57.0,
                      fontWeight: FontWeight.w900,
                      color: kprimarycolor,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Email',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is Required';
                      }
                      if (!RegExp(
                              r"[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'+/=?^_`{|}~-]+)@(?:[a-z0-9](?:[a-z0-9-][a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
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
                    keyboardType: TextInputType.text,
                    controller: _firstnameController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'First Name',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'First Name is Required';
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
                    keyboardType: TextInputType.text,
                    controller: _lastnameController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Last Name',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Last Name is Required';
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
                    keyboardType: TextInputType.phone,
                    controller: _mobileController,
                    maxLength: 10,
                    decoration:
                        kTextInputDecoration.copyWith(hintText: 'Mobile'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mobile Number is Required';
                      }
                      if (!RegExp(r"[0-9]{10}?").hasMatch(value)) {
                        return 'Enter a valid mobile number';
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
                    keyboardType: TextInputType.text,
                    controller: _addressController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Address',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address is Required';
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
                    keyboardType: TextInputType.text,
                    controller: _countryController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Country',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Country is Required';
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
                    keyboardType: TextInputType.text,
                    controller: _stateController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'State',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'State is Required';
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
                    keyboardType: TextInputType.text,
                    controller: _cityController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'City',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'City is Required';
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
                    keyboardType: TextInputType.number,
                    controller: _pincodeController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Pin Code',
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 21.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is Required';
                      }
                      if (!RegExp(r"[0-9]{6}?").hasMatch(value)) {
                        return 'Enter a valid pincode';
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
                      if (!RegExp(
                              r"[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'+/=?^_`{|}~-]+)@(?:[a-z0-9](?:[a-z0-9-][a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                        return 'Enter a valid password';
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
                    obscureText: obscureCPwdText,
                    controller: _cpwdController,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureCPwdText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureCPwdText = !obscureCPwdText;
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
                      if (!RegExp(
                              r"[a-z0-9!#$%&'+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'+/=?^_`{|}~-]+)@(?:[a-z0-9](?:[a-z0-9-][a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                        return 'Enter a valid password';
                      }
                      if (_pwdController.text.toString() !=
                          _cpwdController.text.toString()) {
                        return 'Enter the password same as above';
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
                  CustomTextButton(
                    onPressed: () {
                      if (!_regPageFormKey.currentState!.validate())
                        return;
                      else {
                        _signUpButtonPressed();
                      }
                    },
                    buttonText: 'SIGN UP',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginPage.routename,
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'LOG IN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: kprimarycolor,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}