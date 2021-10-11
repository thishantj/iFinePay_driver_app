import 'package:drivers_app/constants.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:flutter/material.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: displayHeight(context) * 0.05),
              Text("OTP Verification", style: headingStyle),
              Text("We sent your code to 076 867 ***"),
              buildTimer(),
              SizedBox(height: displayHeight(context) * 0.15),
              OtpForm(),
              SizedBox(height: displayHeight(context) * 0.1),
              GestureDetector(
                onTap: () {
                  //resend your OTP
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {},
        )
      ],
    );
  }
}
