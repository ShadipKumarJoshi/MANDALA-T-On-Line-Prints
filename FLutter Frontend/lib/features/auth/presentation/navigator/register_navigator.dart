import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerViewNavigatorProvider =
    Provider((ref) => RegisterViewNavigator());

//route
class RegisterViewNavigator with LoginViewRoute {}

//mixin
// A mixin is a way to reuse a class’s code in multiple class hierarchies.
mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}
