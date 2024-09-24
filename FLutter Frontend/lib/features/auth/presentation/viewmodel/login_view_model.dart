import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, void>(
  (ref) => LoginViewModel(ref.read(loginViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named loginViewModelProvider.
// It creates an instance of LoginViewModel and associates it with the loginViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class LoginViewModel extends StateNotifier<void> {
  LoginViewModel(this.navigator) : super(null);

  final LoginViewNavigator navigator;

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openDashboardView() {
    navigator.openDashboardView();
  }

  void openForgotPasswordView() {
    navigator.openForgotPasswordView();
  }
}
