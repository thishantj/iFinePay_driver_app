import 'dart:convert';

import 'package:drivers_app/components/dbConnection.dart';
import 'package:drivers_app/components/default_button.dart';
import 'package:drivers_app/components/violationDetailArguments.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:drivers_app/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'violation_list_record.dart';

Color bgColor;

class ViolationDetailBody extends StatefulWidget {
  const ViolationDetailBody({
    Key key,
    @required this.args,
  }) : super(key: key);

  final ViolationDetailArguments args;

  @override
  _ViolationDetailBodyState createState() => _ViolationDetailBodyState();
}

class _ViolationDetailBodyState extends State<ViolationDetailBody> {
  Future getViolationDetails() async {
    var url = DBConnect().conn + "/readViolationDetails.php";
    var response = await http.post(Uri.parse(url), body: {
      "violation_id": widget.args.violationId,
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    data.forEach((element) => print(element));
    return data;
  }

  bool checkVisibility()
  {
    if(widget.args.payment.toLowerCase() == "paid")
    {
      return false;
    }
    else
    {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.args.payment.toLowerCase() == "paid") {
      setState(() {
        bgColor = Colors.green;
      });
    } else {
      setState(() {
        bgColor = Colors.redAccent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: displayWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(displayWidth(context) * 0.15),
              ),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: displayWidth(context) * 0.1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: displayHeight(context) * 0.08,
                      ),
                      Row(
                        children: [
                          Text(
                            "Violation id: ",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          Flexible(
                            child: Text(
                              widget.args.violationId,
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.08,
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment status: ",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          Icon(
                            Icons.assignment_late,
                            size: displayWidth(context) * 0.1,
                            color: bgColor,
                          ),
                          Text(
                            widget.args.payment,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                              color: bgColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.08,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getViolationDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          return ViolationDetailList(
                            numberplate: list[index]['number_plate'],
                            violationtype: list[index]['violation_type_id'],
                            policeofficer: list[index]['police_o'],
                            time: list[index]['time'],
                            date: list[index]['date'],
                            expirydate: list[index]['exp_date'],
                            courtdate: list[index]['court_date'],
                            policestationid: list[index]['p_s_id'],
                            courtid: list[index]['court_id'],
                            location: list[index]['location'],
                            district: list[index]['district'],
                            province: list[index]['province'],
                            price: list[index]['price'],
                            finesheet: list[index]['finesheet'],
                            payment: widget.args.payment,
                            paymentmethod: list[index]['payment_method'],
                            paymentdate: list[index]['payment_date'],
                            paymenttime: list[index]['payment_time'],
                          );
                        },
                      )
                    : Text("");
              },
            ),
          ),
          Visibility(
            visible: checkVisibility(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                displayWidth(context) * 0.075,
                displayWidth(context) * 0.05,
                displayWidth(context) * 0.075,
                displayWidth(context) * 0.05,
              ),
              child: DefaultButton(
                text: "Pay",
                press: () {
                  Navigator.pushNamed(context, PaymentScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
