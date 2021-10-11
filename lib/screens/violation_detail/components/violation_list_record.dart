import 'package:drivers_app/screen_helper.dart';
import 'package:flutter/material.dart';

class ViolationDetailList extends StatefulWidget {
  const ViolationDetailList({
    Key key,
    @required this.numberplate,
    this.violationtype,
    this.policeofficer,
    this.time,
    this.date,
    this.expirydate,
    this.courtdate,
    this.policestationid,
    this.courtid,
    this.location,
    this.district,
    this.province,
    this.price,
    this.finesheet,
    this.payment,
    this.paymentmethod,
    this.paymentdate,
    this.paymenttime,
    this.visibility,
  }) : super(key: key);

  final String numberplate;
  final String violationtype;
  final String policeofficer;
  final String time;
  final String date;
  final String expirydate;
  final String courtdate;
  final String policestationid;
  final String courtid;
  final String location;
  final String district;
  final String province;
  final String price;
  final String finesheet;
  final String payment;
  final String paymentmethod;
  final String paymentdate;
  final String paymenttime;
  final bool visibility;

  @override
  _ViolationDetailListState createState() => _ViolationDetailListState();
}

bool paymentVisibility;
String paymeth;
String paydate;
String paytime;

class _ViolationDetailListState extends State<ViolationDetailList> {
  Color bgColor;
  Icon paymentIcon;

  @override
  void initState() {
    super.initState();
    if (widget.payment.toLowerCase() == "paid") {
      setState(() {
        paymentVisibility = true;
        bgColor = Colors.green;
        paymentIcon = Icon(
          Icons.location_on_rounded,
          color: Colors.green,
          size: 50,
        );
      });
    } else {
      setState(() {
        paymentVisibility = false;
        bgColor = Colors.redAccent;
        paymentIcon = Icon(
          Icons.location_on_rounded,
          color: Colors.redAccent,
          size: 50,
        );
      });
    }

    if (widget.paymentmethod == null &&
        widget.paymentdate == null &&
        widget.paymenttime == null) {
      paymeth = "method";
      paydate = "date";
      paytime = "time";
    } else {
      paymeth = widget.paymentmethod;
      paydate = widget.paymentdate;
      paytime = widget.paymenttime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Vehicle number plate",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.numberplate,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.list_alt_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Violation type",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.violationtype,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.local_police_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Police officer",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.policeofficer,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.timer_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Time of violation",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.date_range_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Date of violation",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.date,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Expiry date",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.expirydate,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Court date",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.courtdate,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.business_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Police station ID",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.policestationid,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.gavel_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Court ID",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.courtid,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: paymentIcon,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Container(
                            height: displayHeight(context) * 0.1,
                            child: Flexible(
                              child: Text(
                                widget.location +
                                    ",\n" +
                                    widget.district +
                                    ",\n" +
                                    widget.province,
                                style: TextStyle(
                                  fontSize: displayWidth(context) * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.monetization_on_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.price,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              color: Colors.lightBlue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
                        Icons.book_online_rounded,
                        color: bgColor,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: displayWidth(context) * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Fine sheet",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.finesheet,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: paymentVisibility,
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                elevation: 10,
                color: Colors.lightBlue[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Icon(
                          Icons.book_online_rounded,
                          color: bgColor,
                          size: 50,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: displayWidth(context) * 0.1,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Payment method",
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.045,
                              ),
                            ),
                            SizedBox(
                              height: displayWidth(context) * 0.025,
                            ),
                            Text(
                              paymeth,
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: paymentVisibility,
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                elevation: 10,
                color: Colors.lightBlue[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Icon(
                          Icons.book_online_rounded,
                          color: bgColor,
                          size: 50,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: displayWidth(context) * 0.1,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Payment date and time",
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.045,
                              ),
                            ),
                            SizedBox(
                              height: displayWidth(context) * 0.025,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  paydate,
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: displayWidth(context) * 0.125,
                                ),
                                Text(
                                  paytime,
                                  style: TextStyle(
                                    fontSize: displayWidth(context) * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
