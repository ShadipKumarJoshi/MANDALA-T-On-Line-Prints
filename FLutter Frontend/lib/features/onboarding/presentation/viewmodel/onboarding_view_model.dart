
import 'package:final_assignment/features/onboarding/presentation/navigator/onboarding_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel, void>(
  (ref) => OnboardingViewModel(ref.read(onboardingViewNavigatorProvider)),
);

// This line defines a StateNotifierProvider named onboardingViewModelProvider.
// It creates an instance of OnboardingViewModel and associates it with the onboardingViewNavigatorProvider.
// The void type parameter indicates that this provider doesn’t have any state value; it only manages actions.
class OnboardingViewModel extends StateNotifier<void> {
  OnboardingViewModel(this.navigator) : super(null);

  final OnboardingViewNavigator navigator;

  void openLoginView() {
    navigator.openLoginView();
  }

}
