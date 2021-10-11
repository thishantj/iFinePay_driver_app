import 'package:drivers_app/screen_helper.dart';
import 'package:drivers_app/screens/sign_in/components/no_account_text.dart';
import 'package:flutter/material.dart';

import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: displayHeight(context) * 0.04),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: displayHeight(context) * 0.08),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    displayWidth(context) * 0.05,
                    0,
                    displayWidth(context) * 0.05,
                    0,
                  ),
                  child: SignForm(),
                ),
                SizedBox(height: displayHeight(context) * 0.08),
                SizedBox(height: 20),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
