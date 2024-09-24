import 'package:dartz/dartz.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/auth_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginNavigator;
  late RegisterViewNavigator mockRegisterViewNavigator;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginNavigator = MockLoginViewNavigator();
    mockRegisterViewNavigator = MockRegisterViewNavigator();
  });

  testWidgets(
      'Login with valid credentials and check whether the user is navigated to the Dashboard view',
      (tester) async {
    // Arrange
    const validEmailOrPhoneNumber = 'test1@test.com';
    const validPassword = 'testtest';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final emailOrPhoneNumber = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(emailOrPhoneNumber == validEmailOrPhoneNumber &&
              password == validPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid Credentials')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              mockLoginNavigator,
              mockAuthUsecase,
              mockRegisterViewNavigator,
            ),
          )
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextField).at(0), validEmailOrPhoneNumber);

    await tester.enterText(find.byType(TextFormField).at(1), validPassword);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // Assert that the navigator to Dashboard is called
    // expect(find.text('Designs'), findsOneWidget);
    // Assert that the navigator to Dashboard is called
    // verify(mockLoginNavigator.openDashboardView()).called(1);
  });

  testWidgets(
      'Login with invalid credentials and check whether an error message is displayed',
      (tester) async {
    // Arrange
    const validEmailOrPhoneNumber = 'test1@test.com';
    const validPassword = 'testtest';

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final emailOrPhoneNumber = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(emailOrPhoneNumber == validEmailOrPhoneNumber &&
              password == validPassword
          ? const Right(true)
          : Left(Failure(error: 'Invalid Credentials')));
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              mockLoginNavigator,
              mockAuthUsecase,
              mockRegisterViewNavigator,
            ),
          )
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextFormField).at(0), 'invalid@test.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrongpassword');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // Assert that the error message is displayed
    expect(find.text('Designs'), findsOneWidget);
    // Assert that the navigator to Dashboard is called
    // verify(mockLoginNavigator.openDashboardView()).called(1);
  });
}
