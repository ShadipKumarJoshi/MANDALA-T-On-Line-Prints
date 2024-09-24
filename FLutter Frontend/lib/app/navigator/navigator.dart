import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';

// NavigateRoute class has a private constructor (NavigateRoute._()) to prevent direct instantiation.
class NavigateRoute {
  NavigateRoute._();

  // Open another Screen
  static void pushRoute(Widget view) {
    Navigator.push(
      AppNavigator.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  // Close the current Screen and Open another Screen
  static void popAndPushRoute(Widget view) {
    Navigator.pushReplacement(
      AppNavigator.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  // Just Go Back
  static void pop(ProfileView profileView) {
    Navigator.pop(
      AppNavigator.navigatorKey.currentState!.context,
    );
  }
}
