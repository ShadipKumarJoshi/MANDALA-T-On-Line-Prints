import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/forgot_password_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordViewNavigatorProvider = Provider((ref) => ForgotPasswordViewNavigator());

class ForgotPasswordViewNavigator with LoginViewRoute {}

mixin ForgotPasswordViewRoute {
  openForgotPasswordView() {
    NavigateRoute.pushRoute(const ForgotPasswordView());
  }
}
