import 'dart:convert';
import 'dart:io';

import 'package:drivers_app/screens/sign_in/components/custom_surfix.dart';
import 'package:drivers_app/screens/sign_in/components/form_error.dart';
import 'package:drivers_app/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/dbConnection.dart';
import '../../../components/default_button.dart';
import '../../../screen_helper.dart';
import '/constants.dart';

import 'package:http/http.dart' as http;

class RecoverPasswordForm extends StatefulWidget {
  const RecoverPasswordForm({
    Key key,
    @required this.args,
  }) : super(key: key);

  final args;

  @override
  _RecoverPasswordFormState createState() => _RecoverPasswordFormState();
}

class _RecoverPasswordFormState extends State<RecoverPasswordForm> {
  TextEditingController pass = TextEditingController();
  TextEditingController retypePass = TextEditingController();

  Future resetPassword() async {
    if (pass.text == retypePass.text) {
      try {
        var url = DBConnect().conn + "/resetPasswordDriver.php";
        var response = await http.post(Uri.parse(url), body: {
          "username": widget.args,
          "password": pass.text,
        });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          if (data == "Success") {
            Fluttertoast.showToast(
              msg: "Password reset successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12,
            );

            Navigator.pushNamed(context, SignInScreen.routeName);
          } else {
            Fluttertoast.showToast(
              msg: "Unable to reset password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12,
            );
          }
        } else {
          Fluttertoast.showToast(
              msg: "Server error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12,
            );
        }
      } on SocketException catch (e) {
        print('Socket Error: $e');
        Fluttertoast.showToast(
              msg: "No internet",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12,
            );
      } on Error catch (e) {
        print('General Error: $e');
        Fluttertoast.showToast(
              msg: "Server error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 12,
            );
      }
    } else {
      pass.clear();
      retypePass.clear();

      Fluttertoast.showToast(
        msg: "Passwords do not match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12,
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  String retypePassword;
  String password;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPasswordFormField(),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          buildRetypePasswordFormField(),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          FormError(errors: errors),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          DefaultButton(
            text: "Reset",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                resetPassword();
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
            errors.remove(kShortPassError);
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
        suffixIcon: CustomSuffixcon(
          svgIcon: "assets/icons/password.svg",
        ),
      ),
    );
  }

  TextFormField buildRetypePasswordFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: displayWidth(context) * 0.045,
      ),
      controller: retypePass,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          if (pass == retypePass && errors.contains(kMatchPassError)) {
            setState(() {
              errors.remove(kPassNullError);
            });
          } else if (pass != retypePass && errors.contains(kMatchPassError)) {
            // setState(() {
            //   errors.remove(kMatchPassError);
            // });
          } else {
            setState(() {
              errors.add(kMatchPassError);
            });
          }
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
            errors.remove(kShortPassError);
          });
          return "";
        } else if (value.isNotEmpty &&
            (errors.contains(kPassNullError) ||
                !errors.contains(kPassNullError))) {
          if (pass == retypePass && errors.contains(kMatchPassError)) {
            setState(() {
              errors.remove(kMatchPassError);
            });
          } else if (pass != retypePass && errors.contains(kMatchPassError)) {
            // setState(() {
            //   errors.remove(kMatchPassError);
            // });
          } else {
            setState(() {
              errors.add(kMatchPassError);
            });
          }
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Retype password",
        labelStyle: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.grey[700],
        ),
        hintText: "Re-enter your password",
        hintStyle: TextStyle(
          fontSize: displayWidth(context) * 0.03,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixcon(
          svgIcon: "assets/icons/password.svg",
        ),
      ),
    );
  }
}
