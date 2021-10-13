import 'package:drivers_app/screen_helper.dart';
import 'package:flutter/material.dart';

class ProfileDetailList extends StatefulWidget {
  const ProfileDetailList({
    Key key,
    //@required
    this.nic,
    this.address,
    this.dob,
    this.issueddate,
    this.expirydate,
    this.bloodgroup,
  }) : super(key: key);

  final String nic;
  final String address;
  final String dob;
  final String issueddate;
  final String expirydate;
  final String bloodgroup;

  @override
  _ProfileDetailListState createState() => _ProfileDetailListState();
}

class _ProfileDetailListState extends State<ProfileDetailList> {
  Color bgColor;
  Icon paymentIcon;

  @override
  void initState() {
    super.initState();
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
                        Icons.credit_card_rounded,
                        color: Colors.amber,
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
                            "NIC",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.nic,
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
                        Icons.home,
                        color: Colors.deepPurpleAccent,
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
                            "Address",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Container(
                            width: displayWidth(context) * 0.5,
                            child: Text(
                              widget.address,
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.05,
                                fontWeight: FontWeight.bold,
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
                        Icons.timer_rounded,
                        color: Colors.blueAccent,
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
                            "Date of birth",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.dob,
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
                        color: Colors.green,
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
                            "License issue date",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.045,
                            ),
                          ),
                          SizedBox(
                            height: displayWidth(context) * 0.025,
                          ),
                          Text(
                            widget.issueddate,
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
                        color: Colors.redAccent,
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
                            "License expiry date",
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
      ],
    );
  }
}
