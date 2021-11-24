import 'dart:convert';

import 'package:drivers_app/components/dbConnection.dart';
import 'package:drivers_app/components/default_button.dart';
import 'package:drivers_app/components/user.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:drivers_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:drivers_app/screens/homescreen/home_screen.dart';
//import 'package:drivers_app/screens/login_success/login_success_screen.dart';
import 'package:drivers_app/screens/sign_in/components/custom_surfix.dart';
import 'package:drivers_app/screens/sign_in/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController licenseno = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirm = TextEditingController();

  Future signInForm() async {
    var url = DBConnect().conn + "/driverLogin.php";
    var response = await http.post(Uri.parse(url), body: {
      "licenseNumber": licenseno.text,
      "password": pass.text,
    });
    Navigator.of(context).pop();
    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
          msg: "License number or password is incorrect!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Login sucessfull!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      User user = new User();
      user.setLicense(licenseno.text);

      if (remember == true) {
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt("user", int.parse(license));

        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  String license;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forget Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                signInForm();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: displayWidth(context) * 0.045,
      ),
      controller: pass,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.isEmpty && errors.contains(kPassNullError)) {
          setState(() {
            //errors.add(kShortPassError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.grey[700],
        ),
        hintText: "Enter your password",
        hintStyle: TextStyle(
          fontSize: displayWidth(context) * 0.03,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixcon(svgIcon: "assets/icons/password.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: displayWidth(context) * 0.045,
      ),
      controller: licenseno,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => license = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
        } else if (value.isEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kInvaidEmailError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "License",
        labelStyle: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.grey[700],
        ),
        hintText: "Enter your license",
        hintStyle: TextStyle(
          fontSize: displayWidth(context) * 0.03,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixcon(svgIcon: "assets/icons/username.svg"),
      ),
    );
  }
}
