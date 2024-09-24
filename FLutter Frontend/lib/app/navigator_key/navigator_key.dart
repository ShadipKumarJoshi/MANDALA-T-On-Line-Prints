import 'package:flutter/material.dart';

// AppNavigator class has a private constructor (AppNavigator._()) to prevent direct instantiation.
// It also contains a static field called navigatorKey, which is an instance of GlobalKey<NavigatorState>.
// The purpose of navigatorKey is to manage navigation within the app using Flutter’s navigation system.

// This way we don't have to pass the BuildContect in ViewModel
class AppNavigator {
  AppNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
}
