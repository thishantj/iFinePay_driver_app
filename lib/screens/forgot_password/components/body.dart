import 'package:drivers_app/components/default_button.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:drivers_app/screens/otp/otp_screen.dart';
import 'package:drivers_app/screens/sign_in/components/custom_surfix.dart';
import 'package:drivers_app/screens/sign_in/components/form_error.dart';
import 'package:drivers_app/screens/sign_in/components/no_account_text.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: displayHeight(context) * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your license number and we will send \nyou an OTP to reset your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: displayHeight(context) * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String email;
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: user,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvaidEmailError)) {
                setState(() {
                  errors.remove(kInvaidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvaidEmailError)) {
                setState(() {
                  errors.add(kInvaidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "License number",
              hintText: "Enter your license number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixcon(svgIcon: "assets/icons/username.svg"),
            ),
          ),
          SizedBox(height: 30),
          FormError(errors: errors),
          SizedBox(height: displayHeight(context) * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                Navigator.pushNamed(context, OtpScreen.routeName, arguments: user.text);
              }
            },
          ),
          SizedBox(height: displayHeight(context) * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
