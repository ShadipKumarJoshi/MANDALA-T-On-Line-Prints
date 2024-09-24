import 'package:final_assignment/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:final_assignment/features/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SplashViewNavigator>()])
void main() {
  late SplashViewNavigator mockSplashViewNavigator;
  late ProviderContainer container;

  setUp(() {
    mockSplashViewNavigator = MockSplashViewNavigator();
    container = ProviderContainer(overrides: [
      splashViewModelProvider.overrideWith(
        (ref) => SplashViewModel(mockSplashViewNavigator),
      ),
    ]);
  });

  test('openLoginView should navigate to Onboarding view after delay',
      () async {
    // Act
    container.read(splashViewModelProvider.notifier).openLoginView();

    // Assert
    await untilCalled(mockSplashViewNavigator.openOnboardingView());
    verify(mockSplashViewNavigator.openOnboardingView()).called(1);
  });

  tearDown(() {
    container.dispose();
  });
}
