import 'dart:convert';

import 'package:drivers_app/components/dbConnection.dart';
import 'package:drivers_app/components/user.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:drivers_app/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_detail_list.dart';

String driverName = "";

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  Future getProfileDetails() async {
    var url = DBConnect().conn + "/readProfileDetails.php";
    var response = await http.post(Uri.parse(url), body: {
      //"licenseNumber": User().getLicense(),
      "licenseNumber": "B1234567",
    });

    var data = json.decode(response.body).cast<Map<String, dynamic>>();
    data.forEach((element) => print(element));
    return data;
  }

  Future getDriverName() async {
    var url = DBConnect().conn + "/readDrivername.php";
    var response = await http.post(Uri.parse(url), body: {
      //"licenseNumber": User().getLicense(),
      "licenseNumber": "B1234567",
    });

    var data = json.decode(response.body);

    if (data != null) {
      setState(() {
        driverName = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //getDriverName();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Container(
            height: displayHeight(context) * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: displayWidth(context) * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          sharedPreferences.remove("user");

                          Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size: displayWidth(context) * 0.065,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.03,
                ),
                Text(
                  //driverName,
                  "driverName",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: displayWidth(context) * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "License number:   ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.04,
                      ),
                    ),
                    Text(
                      //User().getLicense(),
                      "B1234567",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Container(
            width: displayWidth(context),
            height: displayHeight(context) * 0.75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(displayWidth(context) * 0.15),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                // Expanded(
                //   //flex: 2,
                //   child: FutureBuilder(
                //     future: getProfileDetails(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasError) print(snapshot.error);
                //       return snapshot.hasData
                //           ? ListView.builder(
                //               itemCount: snapshot.data.length,
                //               itemBuilder: (context, index) {
                //                 List list = snapshot.data;
                //                 return ProfileDetailList(
                //                   nic: list[index]['nic'],
                //                   address: list[index]['address'],
                //                   dob: list[index]['dob'],
                //                   issueddate: list[index]['issuedate'],
                //                   expirydate: list[index]['expirydate'],
                //                   bloodgroup: list[index]['bloodgroup'],
                //                 );
                //               },
                //             )
                //           : Text("");
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
