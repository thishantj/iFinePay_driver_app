import 'dart:convert';
import 'package:drivers_app/screens/homescreen/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:drivers_app/components/dbConnection.dart';
import 'package:drivers_app/components/default_button.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:drivers_app/screens/sign_in/components/custom_surfix.dart';
import 'package:drivers_app/screens/sign_in/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:credit_card_validator/credit_card_validator.dart';
import '../../../constants.dart';

CreditCardValidator _ccValidator = CreditCardValidator();

class PaymentForm extends StatefulWidget {
  const PaymentForm({
    Key key,
    this.violationId,
    this.price,
  }) : super(key: key);

  final String violationId;
  final int price;

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  TextEditingController cardno = TextEditingController();
  TextEditingController cvvno = TextEditingController();
  TextEditingController expmonth = TextEditingController();
  TextEditingController expyear = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String card;
  String cvv;
  String expiremonth;
  String expireyear;
  bool remember = false;
  final List<String> errors = [];

  FocusNode expMonth;
  FocusNode expYear;

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
  void initState() {
    super.initState();
    expMonth = FocusNode();
    expYear = FocusNode();
  }

  @override
  void dispose() {
    expMonth.dispose();
    expYear.dispose();
    super.dispose();
  }

  void nextFeild({String value, FocusNode focusNode}) {
    if (value.length == 2) {
      focusNode.requestFocus();
    }
  }

  Future pay() async {
    var ccNumResults = _ccValidator.validateCCNum(cardno.text);
    String expdate = expmonth.text + "/" + expyear.text;
    var expDateResults = _ccValidator.validateExpDate(expdate);
    var cvvResults = _ccValidator.validateCVV(cvvno.text, ccNumResults.ccType);

    print("CC: " + ccNumResults.isValid.toString());
    print("Expire date: " + expDateResults.isValid.toString());
    print("CVV: " + cvvResults.isValid.toString());

    if(ccNumResults.isValid.toString() == "true" && expDateResults.isValid.toString() == "true" && cvvResults.isValid.toString() == "true")
    {
      var url = DBConnect().conn + "/makePayment.php";
      var response = await http.post(Uri.parse(url), body: {
        "violation_id": widget.violationId,
        "payment_method": "Card",
        "payment_date": getCurrentDate(),
        "payment_time": getCurrentTime(),
      });

      var data = json.decode(response.body);

      if(data == "success")
      {
        Navigator.pushNamed(context, HomeScreen.routeName);
      }
      else
      {
        Fluttertoast.showToast(
            msg: "Cannot update record",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    else
    {
      Fluttertoast.showToast(
            msg: "Card number is not valid",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
    }
  }

  static String getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate.toString();
  }

  static String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm').format(now);

    return formattedTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          buildCardNumberFormField(),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Expire date:"),
                      Text("(MM/YY)"),
                    ],
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.015,
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.1,
                    child: TextFormField(
                      //autofocus: true,
                      controller: expmonth,
                      onSaved: (newValue) => expiremonth = newValue,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.04,
                      ),
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        nextFeild(value: value, focusNode: expYear);
                      },
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.015,
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.1,
                    child: TextFormField(
                      focusNode: expYear,
                      controller: expyear,
                      onSaved: (newValue) => expireyear = newValue,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.04,
                      ),
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        if (value.length == 2) {
                          expYear.unfocus();
                        }
                      },
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: displayWidth(context) * 0.4,
                child: buildCVVFormField(),
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Amount:",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: displayWidth(context) * 0.04,
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.01,
              ),
              Row(
                children: [
                  Text(
                    "Rs. ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: displayWidth(context) * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.price.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: displayWidth(context) * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          FormError(errors: errors),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          DefaultButton(
            text: "Pay",
            press: () {
              // set method on click
              pay();
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildCVVFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: displayWidth(context) * 0.045,
      ),
      controller: cvvno,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => cvv = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        }
        if (value.length == 3 &&
            errors.contains("CVV can be only 3 characters")) {
          setState(() {
            errors.remove("CVV can be only 3 characters");
          });
        }
        if (value.length < 3 && errors.contains("CVV must be 3 characters")) {
          setState(() {
            errors.add("CVV must be 3 characters");
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
        if (value.length > 3 &&
            !errors.contains("CVV can be only 3 characters")) {
          setState(() {
            errors.add("CVV can be only 3 characters");
          });
        }
        if (value.length < 3 && !errors.contains("CVV must be 3 characters")) {
          setState(() {
            errors.add("CVV must be 3 characters");
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "CVV",
        labelStyle: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.grey[700],
        ),
        hintText: "CVV",
        hintStyle: TextStyle(
          fontSize: displayWidth(context) * 0.03,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixcon(svgIcon: "assets/icons/password.svg"),
      ),
    );
  }

  TextFormField buildCardNumberFormField() {
    return TextFormField(
      style: TextStyle(
        fontSize: displayWidth(context) * 0.045,
      ),
      controller: cardno,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => card = newValue,
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
        labelText: "Card number",
        labelStyle: TextStyle(
          fontSize: displayWidth(context) * 0.04,
          color: Colors.grey[700],
        ),
        hintText: "Enter your card number",
        hintStyle: TextStyle(
          fontSize: displayWidth(context) * 0.03,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixcon(svgIcon: "assets/icons/password.svg"),
      ),
    );
  }
}
