import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/onboarding/presentation/view/onboarding_view.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingViewNavigatorProvider = Provider((ref) => OnboardingViewNavigator());

class OnboardingViewNavigator with  LoginViewRoute {}

mixin OnboardingViewRoute {
  openOnboardingView() {
    NavigateRoute.pushRoute(const OnboardingView());
  }
}
