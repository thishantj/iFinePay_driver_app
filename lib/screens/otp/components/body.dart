import 'dart:convert';
import 'dart:io';

import 'package:drivers_app/components/dbConnection.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'otp_form.dart';

int numberEnd;
int telephone;

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    getPolicePhoneNumber();
    sendOTP();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.04,
              ),
              Text(
                "Recovery OTP",
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.08,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.03,
              ),
              Text(
                "Please enter the recovery code received to your number ending with *******" +
                    numberEnd.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.035,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.05,
              ),
              buildTimer(context),
              SizedBox(
                height: displayHeight(context) * 0.1,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  displayWidth(context) * 0.05,
                  0,
                  displayWidth(context) * 0.05,
                  0,
                ),
                child: OtpForm(args: widget.args),
              ),
              SizedBox(
                height: displayHeight(context) * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  sendOTP();
                },
                child: Text(
                  "Resend OTP code",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: displayWidth(context) * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getPolicePhoneNumber() async {
    try {
      var url = DBConnect().conn + "/readDriverPhone.php";
      var response = await http.post(Uri.parse(url), body: {
        "username": widget.args,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("data: " + data);
        telephone = data;
        getNumberEnd(data);
      } else {
        Fluttertoast.showToast(
          msg: "Cannot get phone number!",
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

  void getNumberEnd(var data) {
    setState(() {
      numberEnd = int.parse(data.substring(data.length - 3));
    });
  }

  Future sendOTP() async {
    try {
      var url = DBConnect().conn + "/sendOTPDriver.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": widget.args,
        "tel": telephone,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("data: " + data);
      } else {
        Fluttertoast.showToast(
          msg: "OTP cannot be sent!",
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
}

Row buildTimer(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "This code will expire in ",
        style: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.black45,
        ),
      ),
      TweenAnimationBuilder(
        tween: Tween(begin: 60.0, end: 0),
        duration: Duration(seconds: 60),
        builder: (context, value, child) => Text(
          "00:${value.toInt()}",
          style: TextStyle(
            color: Colors.red[400],
            fontSize: displayWidth(context) * 0.045,
          ),
        ),
        onEnd: () {},
      ),
    ],
  );
}
