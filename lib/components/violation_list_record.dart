import 'package:drivers_app/components/violationDetailArguments.dart';
import 'package:drivers_app/screen_helper.dart';
import 'package:drivers_app/screens/violation_detail/violation_detail_screen.dart';
import 'package:flutter/material.dart';

class ViolationListRecord extends StatefulWidget {
  const ViolationListRecord({
    Key key,
    @required this.violationId,
    this.price,
    this.payment,
    this.licenseNo,
  }) : super(key: key);

  final String violationId;
  final String price;
  final String payment;
  final String licenseNo;

  @override
  _ViolationListRecordState createState() => _ViolationListRecordState();
}

class _ViolationListRecordState extends State<ViolationListRecord> {
  Color bgColor;
  Icon paymentIcon;

  @override
  void initState() {
    super.initState();
    if (widget.payment == "paid" || widget.payment == "Paid") {
      setState(() {
        bgColor = Colors.greenAccent;
        paymentIcon = Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 50,
        );
      });
    } else {
      setState(() {
        bgColor = Colors.redAccent;
        paymentIcon = Icon(
          Icons.do_not_disturb_on_rounded,
          color: Colors.redAccent,
          size: 50,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    widget.violationId,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Rs.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.price,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                paymentIcon,
                IconButton(
                  onPressed: (){
                    ViolationDetailArguments vda = new ViolationDetailArguments(widget.violationId, widget.payment, widget.licenseNo);
                    Navigator.pushNamed(context, ViolationDetailScreen.routeName, arguments: vda);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.green,
                    size: displayWidth(context) * 0.05,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
