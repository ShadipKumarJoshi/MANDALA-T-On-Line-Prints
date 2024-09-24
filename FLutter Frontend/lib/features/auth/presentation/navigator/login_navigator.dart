import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/forgot_password_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/dashboard/presentation/navigator/dashboard_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator
    with RegisterViewRoute, ForgotPasswordViewRoute, DashboardViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.pushRoute(const LoginView());
  }
}
