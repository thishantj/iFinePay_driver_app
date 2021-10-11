import 'package:drivers_app/components/violationDetailArguments.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class ViolationDetailScreen extends StatelessWidget {
  
  static String routeName = "/violation_detail";

  @override
  Widget build(BuildContext context) {

    final ViolationDetailArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: ViolationDetailBody(args: args),
    );
  }
}