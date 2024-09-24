import 'package:final_assignment/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// create a provider for SplashViewScreen to be used in SplashView
final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  return SplashViewModel(navigator);
});

// Implement StateNotifier
class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator) : super(null);

  final SplashViewNavigator navigator;

  //open login page
  void openLoginView() {
    Future.delayed(const Duration(seconds: 10), () {
      navigator.openOnboardingView();
      // navigator.openLoginView();
    });
  }

  //later on we will add open home page method here as well

  void openHomeView() {}
}
