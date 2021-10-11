import 'package:drivers_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:drivers_app/screens/otp/otp_screen.dart';
import 'package:drivers_app/screens/profile/profile_screen.dart';
import 'package:drivers_app/screens/sign_in/sign_in_screen.dart';
import 'package:drivers_app/screens/sign_up/sign_up_screen.dart';
import 'package:drivers_app/screens/violation_detail/violation_detail_screen.dart';
import 'package:flutter/material.dart';

import 'screens/homescreen/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ViolationDetailScreen.routeName: (context) => ViolationDetailScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
