import 'package:final_assignment/features/onboarding/presentation/navigator/onboarding_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());

//this class will be used to navigate to LoginView
class SplashViewNavigator with OnboardingViewRoute {}

// direct login code here
// LoginViewRoute

mixin SplashViewRoute {}
