import 'dart:convert';

import 'package:eauc/constants.dart';
import 'package:eauc/databasemodels/UserModel.dart';
import 'package:eauc/uiscreens/profile/my_account_page.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditAccountPage extends StatefulWidget {
  final String email,
      firstname,
      lastname,
      mobile,
      address,
      country,
      state,
      city,
      pincode;

  EditAccountPage({
    required this.email,
    required this.firstname,
    required this.city,
    required this.pincode,
    required this.country,
    required this.address,
    required this.lastname,
    required this.mobile,
    required this.state,
  });

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final GlobalKey<FormState> _editPageFormKey = GlobalKey<FormState>();
  bool _loading = false;

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _firstnameController.text = widget.firstname;
    _lastnameController.text = widget.lastname;
    _mobileController.text = widget.mobile;
    _addressController.text = widget.address;
    _countryController.text = widget.country;
    _stateController.text = widget.state;
    _cityController.text = widget.city;
    _pincodeController.text = widget.pincode;
  }

  void _editButtonPressed() async {
    setState(() {
      _loading = true;
    });
    var url = apiUrl + "updateUserData.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": widget.email,
      "firstname": _firstnameController.text,
      "lastname": _lastnameController.text,
      "contact": _mobileController.text,
      "addr": _addressController.text,
      "city": _cityController.text,
      "pincode": _pincodeController.text,
      "states": _stateController.text,
      "country": _countryController.text
    });
    if (jsonDecode(response.body) == 'true') {
      setState(() {
        _loading = false;
      });
      showToast(
        'Profile Updated Successfully',
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideFromBottomFade,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
      );
      Navigator.pop(context);
    } else {
      setState(() {
        _loading = false;
      });
      showToast(
        'Error. Please Try Again',
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideFromBottomFade,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      progressIndicator: CircularProgressIndicator(
        color: kprimarycolor,
        strokeWidth: 3,
      ),
      child: Scaffold(
        backgroundColor: kbackgroundcolor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: kprimarycolor,
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
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _editPageFormKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    LabelText(
                      text: 'Email',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      initialValue: widget.email,
                      onTap: null,
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Email',
                        fillColor: Colors.blueGrey.withOpacity(0.2),
                      ),
                      style: kInputFieldTextStyle.copyWith(
                          color: Colors.grey.shade600),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    LabelText(
                      text: 'First Name: ',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _firstnameController,
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'First Name',
                      ),
                      style: kInputFieldTextStyle,
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
                    LabelText(
                      text: 'Last Name: ',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _lastnameController,
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Last Name',
                      ),
                      style: kInputFieldTextStyle,
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
                    LabelText(
                      text: 'Contact: ',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _mobileController,
                      maxLength: 10,
                      decoration:
                          kInputFieldDecoration.copyWith(hintText: 'Mobile'),
                      style: kInputFieldTextStyle,
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
                    LabelText(
                      text: 'Address: ',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _addressController,
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Address',
                      ),
                      style: kInputFieldTextStyle,
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
                    LabelText(
                      text: 'Country: ',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _countryController,
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Country',
                      ),
                      style: kInputFieldTextStyle,
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
                    LabelText(
                      text: 'State: ',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _stateController,
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'State',
                      ),
                      style: kInputFieldTextStyle,
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
                    LabelText(
                      text: 'City',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _cityController,
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'City',
                      ),
                      style: kInputFieldTextStyle,
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
                    LabelText(
                      text: 'Pincode',
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _pincodeController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: kInputFieldDecoration.copyWith(
                        hintText: 'Pin Code',
                      ),
                      style: kInputFieldTextStyle,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PinCode is Required';
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
                    CustomTextButton(
                      onPressed: () {
                        if (!_editPageFormKey.currentState!.validate())
                          return;
                        else {
                          _editButtonPressed();
                        }
                      },
                      buttonText: 'UPDATE',
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
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  final String text;

  LabelText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            text,
            style: TextStyle(color: kprimarycolor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
