import 'package:drivers_app/components/PaymentDetailArguments.dart';
import 'package:flutter/material.dart';

import '../../../screen_helper.dart';
import 'payment_form.dart';

class PaymentBody extends StatelessWidget {
  const PaymentBody({
    Key key, 
    @required this.args,
  }) : super(key: key);

  final PaymentDetailArguments args;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: displayHeight(context) * 0.04),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    displayWidth(context) * 0.05,
                    0,
                    displayWidth(context) * 0.05,
                    0,
                  ),
                  child: PaymentForm(violationId: args.violationId, price: args.price),
                ),
                SizedBox(height: displayHeight(context) * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
