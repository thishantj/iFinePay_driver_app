import 'package:drivers_app/components/PaymentDetailArguments.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {

    final PaymentDetailArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: PaymentBody(args: args),
    );
  }
}