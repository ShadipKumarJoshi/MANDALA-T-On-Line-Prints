import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerViewModelProvider = StateNotifierProvider<RegisterViewModel, void>(
  (ref) => RegisterViewModel(ref.read(registerViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named registerViewModelProvider.
// It creates an instance of RegisterViewModel and associates it with the registerViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class RegisterViewModel extends StateNotifier<void> {
  RegisterViewModel(this.navigator) : super(null);

  final RegisterViewNavigator navigator;

  void openLoginView() {
    navigator.openLoginView();
  }

 

  }