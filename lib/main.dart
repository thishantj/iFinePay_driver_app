import 'package:drivers_app/routes.dart';
import 'package:drivers_app/screens/payment/payment_screen.dart';
import 'package:drivers_app/screens/sign_in/sign_in_screen.dart';
import 'package:drivers_app/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver app',
      theme: theme(),
      //home: SplashScreen(),
      //initialRoute: SignInScreen.routeName,
      initialRoute: PaymentScreen.routeName,
      routes: routes,
    );
  }
}
