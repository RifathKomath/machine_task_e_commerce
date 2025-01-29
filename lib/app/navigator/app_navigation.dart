import 'package:flutter/material.dart';

class AppNavigator {

  static void pushReplacement(BuildContext context,Widget widget) {
    Navigator.pushReplacement(
      context,
      // MaterialPageRoute(builder: (context) => widget)
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => widget,
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  static void push(BuildContext context,Widget widget) {
    Navigator.push(
      context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: const Duration(seconds: 0),
        ),
      //MaterialPageRoute(builder: (context) => widget)
    );
  }

  static void pushAndRemove(BuildContext context,Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false
    );
  }
}