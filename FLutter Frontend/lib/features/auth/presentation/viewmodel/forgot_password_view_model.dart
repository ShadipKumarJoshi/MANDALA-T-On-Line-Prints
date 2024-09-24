import 'package:final_assignment/features/auth/presentation/navigator/forgot_password_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordViewModelProvider = StateNotifierProvider<ForgotPasswordViewModel, void>(
  (ref) => ForgotPasswordViewModel(ref.read(forgotPasswordViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named forgotPasswordViewModelProvider.
// It creates an instance of ForgotPasswordViewModel and associates it with the forgotPasswordViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class ForgotPasswordViewModel extends StateNotifier<void> {
  ForgotPasswordViewModel(this.navigator) : super(null);

  final ForgotPasswordViewNavigator navigator;

  void openLoginView() {
    navigator.openLoginView();
  }

}
