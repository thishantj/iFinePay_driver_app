import 'dart:convert';
import 'dart:io';

import 'package:drivers_app/components/dbConnection.dart';
import 'package:drivers_app/screens/reset_password/reset_password.dart';
import 'package:drivers_app/screens/sign_in/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/default_button.dart';
import '../../../screen_helper.dart';
import '/constants.dart';

import 'package:http/http.dart' as http;

int otp;

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  Future verifyOTP() async {
    try {

      otp = int.parse(pin1.text + pin2.text + pin3.text + pin4.text);

      var url = DBConnect().conn + "/verifyOTPDriver.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": widget.args,
        "otp": otp,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("data: " + data);

        if (data == "Success") {
          Navigator.pushNamed(context, ResetPasswordScreen.routeName,
              arguments: widget.args);

        } else if (data == "Error1") {
          Fluttertoast.showToast(
          msg: "OTP expired!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        } 
      } else {
        Fluttertoast.showToast(
          msg: "Server error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      Fluttertoast.showToast(
          msg: "Socket error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  autofocus: true,
                  controller: pin1,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        nextField(value: value, focusNode: pin2FocusNode);
                      });
                    } else if (value.isNotEmpty &&
                        !errors.contains(kOTPNullError)) {
                      setState(() {
                        nextField(value: value, focusNode: pin2FocusNode);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  autofocus: true,
                  controller: pin2,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        nextField(value: value, focusNode: pin3FocusNode);
                      });
                    } else if (value.isNotEmpty &&
                        !errors.contains(kOTPNullError)) {
                      setState(() {
                        nextField(value: value, focusNode: pin3FocusNode);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  controller: pin3,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        nextField(value: value, focusNode: pin4FocusNode);
                      });
                    } else if (value.isNotEmpty &&
                        !errors.contains(kOTPNullError)) {
                      setState(() {
                        nextField(value: value, focusNode: pin4FocusNode);
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.15,
                height: displayHeight(context) * 0.1,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  autofocus: true,
                  controller: pin4,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: displayWidth(context) * 0.08,
                  ),
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.isNotEmpty && errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.remove(kOTPNullError);
                        pin4FocusNode.unfocus();
                      });
                    } else if (value.isNotEmpty &&
                        !errors.contains(kOTPNullError)) {
                      setState(() {
                        pin4FocusNode.unfocus();
                      });
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty && !errors.contains(kOTPNullError)) {
                      setState(() {
                        errors.add(kOTPNullError);
                      });
                      return "";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          FormError(errors: errors),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                verifyOTP();
              }
            },
          ),
        ],
      ),
    );
  }
}
