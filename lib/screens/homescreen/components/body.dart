import 'dart:convert';
import 'dart:io';

import 'package:drivers_app/components/customDialog.dart';
import 'package:drivers_app/components/dbConnection.dart';
import 'package:drivers_app/components/user.dart';
import 'package:drivers_app/components/violation_list_record.dart';
import 'package:drivers_app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../screen_helper.dart';

Color bgColor;
String status = "Valid";
String driverName = "";

class ViolationsBody extends StatefulWidget {
  const ViolationsBody({
    Key key,
  }) : super(key: key);

  @override
  _ViolationsBodyState createState() => _ViolationsBodyState();
}

class _ViolationsBodyState extends State<ViolationsBody> {
  Future getLicenseStatus() async {
    try {
      var url = DBConnect().conn + "/readLicence.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": User().getLicense(),
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (int.parse(data) == 1) {
          setState(() {
            bgColor = Colors.greenAccent[400];
            status = "Valid";
          });

          print("done");
        } else if (int.parse(data) == 0) {
          setState(() {
            bgColor = Colors.redAccent[400];
            status = "Blocked";
          });
        }
      } else {}
    } on SocketException catch (e) {
      print('Socket Error: $e');
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  Future getUnpaidViolations() async {
    var url = DBConnect().conn + "/readUnpaidViolations.php";
    var response = await http.post(Uri.parse(url), body: {
      "licenseNumber": User().getLicense(),
    });

    var data;

    if (json.decode(response.body) == "No") {
      print("no records");
    } else {
      data = json.decode(response.body).cast<Map<String, dynamic>>();
      data.forEach((element) => print(element));
    }

    return data;
  }

  Future getAllViolations() async {
    print("l_no: " + User().getLicense());
    var url = DBConnect().conn + "/readViolations.php";
    var response = await http.post(Uri.parse(url), body: {
      "licenseNumber": User().getLicense(),
    });

    var data;

    if (json.decode(response.body) == "No") {
      print("no records");
    } else {
      data = json.decode(response.body).cast<Map<String, dynamic>>();
      data.forEach((element) => print(element));
    }
    return data;
  }

  Future getDriverName() async {
    try {
      var url = DBConnect().conn + "/readDrivername.php";
      var response = await http.post(Uri.parse(url), body: {
        "licenseNumber": User().getLicense(),
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data != null) {
          setState(() {
            driverName = data;
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              alertHeading: "Warning !",
              alertBody: "Server error. Please try again !",
              alertButtonColour: Colors.red,
              alertButtonText: "Ok",
              alertAvatarBgColour: Colors.redAccent,
              alertAvatarColour: Colors.white,
              alertAvatarIcon: Icons.error,
              buttonPress: () => {Navigator.of(context).pop()},
            );
          },
        );
      }
    } on SocketException catch (e) {
      print('Socket Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "No internet. Please check your connectivity !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    } on Error catch (e) {
      print('General Error: $e');
      showDialog(
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            alertHeading: "Warning !",
            alertBody: "Server error. Please try again !",
            alertButtonColour: Colors.red,
            alertButtonText: "Ok",
            alertAvatarBgColour: Colors.redAccent,
            alertAvatarColour: Colors.white,
            alertAvatarIcon: Icons.error,
            buttonPress: () => {Navigator.of(context).pop()},
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    getDriverName();
    getLicenseStatus();
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
                SizedBox(
                  height: displayHeight(context) * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: displayWidth(context) * 0.1),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hi ",
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.065,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.03,
                          ),
                          Text(
                            User().getLicense(),
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.075,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.015,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: displayWidth(context) * 0.2,
                          left: displayWidth(context) * 0.2,
                        ),
                        child: Divider(
                          color: Colors.white,
                          thickness: displayHeight(context) * 0.001,
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.05,
                      ),
                      Row(
                        children: [
                          Text(
                            "Driver name: ",
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
                              driverName,
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
                        height: displayHeight(context) * 0.05,
                      ),
                      Row(
                        children: [
                          Text(
                            "License status: ",
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
                            status,
                            style: TextStyle(
                              fontSize: displayWidth(context) * 0.05,
                              fontWeight: FontWeight.bold,
                              color: bgColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.08,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, ProfileScreen.routeName),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_circle_rounded,
                              size: displayWidth(context) * 0.1,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: displayWidth(context) * 0.03,
                            ),
                            Text(
                              "View profile",
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
              ],
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.06,
          ),
          SizedBox(
            height: displayHeight(context) * 0.4,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    height: displayHeight(context) * 0.07,
                    color: Colors.white,
                    // child: Padding(
                    //   padding: EdgeInsets.all(10.0),
                    child: TabBar(
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: displayWidth(context) * 0.04,
                      ),
                      indicator: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      tabs: [
                        Tab(
                          text: "Violations",
                        ),
                        Tab(
                          text: "Violation history",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: displayHeight(context) * 0.3,
                    child: Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          displayWidth(context) * 0.05,
                          0,
                          displayWidth(context) * 0.05,
                          0,
                        ),
                        child: TabBarView(
                          children: [
                            Expanded(
                              child: FutureBuilder(
                                future: getUnpaidViolations(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.error);
                                  return snapshot.hasData
                                      ? ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            List list = snapshot.data;
                                            return ViolationListRecord(
                                              licenseNo: User().getLicense(),
                                              violationId: list[index]
                                                  ['violation_id'],
                                              price: list[index]['price'],
                                              payment: list[index]['payment'],
                                            );
                                          },
                                        )
                                      : Text("");
                                },
                              ),
                            ),
                            Expanded(
                              child: FutureBuilder(
                                future: getAllViolations(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.error);
                                  return snapshot.hasData
                                      ? ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            List list = snapshot.data;
                                            return ViolationListRecord(
                                              licenseNo: User().getLicense(),
                                              violationId: list[index]
                                                  ['violation_id'],
                                              price: list[index]['price'],
                                              payment: list[index]['payment'],
                                            );
                                          },
                                        )
                                      : Text("");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
