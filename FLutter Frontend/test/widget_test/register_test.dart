// ignore_for_file: deprecated_member_use

import 'package:dartz/dartz.dart';
import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/view/register_view.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../unit_test/auth_test.mocks.dart';

void main() {
  late MockAuthUseCase mockAuthUseCase;
  late MockRegisterViewNavigator mockRegisterViewNavigator;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    mockRegisterViewNavigator = MockRegisterViewNavigator();
  });

  testWidgets("Register user", (tester) async {
    when(mockAuthUseCase.registerUser(any))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(ref.read(loginViewNavigatorProvider),
                mockAuthUseCase, mockRegisterViewNavigator),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          home: const RegisterView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextFormField).at(0), 'Shadip Kumar Joshi');
    await tester.enterText(find.byType(TextFormField).at(1), 'Shadip');
    await tester.enterText(find.byType(TextFormField).at(2), '9234567890');
    await tester.enterText(
        find.byType(TextFormField).at(3), 'shadip@shadip.com');
    await tester.enterText(find.byType(TextFormField).at(4), 'password123');
    await tester.enterText(find.byType(TextFormField).at(5), 'password123');

    // Find the Checkbox widget
    final checkboxFinder = find.byType(Checkbox);

    tester.state(find.byType(RegisterView));
    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    // Assert: Check if the SnackBar is displayed with the correct message
    // expect(find.widgetWithText(SnackBar, "Successfully registered"),
    //     findsOneWidget);

    // // Assert: Verify that the openLoginView method was called after successful registration
    // verify(mockRegisterViewNavigator.openLoginView()).called(1);
  });

  testWidgets("Register user with invalid data", (tester) async {
    // Arrange: Set up mock behavior for registration failure
    when(mockAuthUseCase.registerUser(any))
        .thenAnswer((_) async => Left(Failure(error: "Password mismatch")));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(ref.read(loginViewNavigatorProvider),
                mockAuthUseCase, mockRegisterViewNavigator),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          home: const RegisterView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextFormField).at(0), 'Shadip Kumar Joshi');
    await tester.enterText(find.byType(TextFormField).at(1), 'Shadip');
    await tester.enterText(find.byType(TextFormField).at(2), '9234567890');
    await tester.enterText(
        find.byType(TextFormField).at(3), 'shadip@shadip.com');
    await tester.enterText(find.byType(TextFormField).at(4), 'password123');
    await tester.enterText(find.byType(TextFormField).at(5), 'password');

    // Find the Checkbox widget
    final checkboxFinder = find.byType(Checkbox);

    tester.state(find.byType(RegisterView));
    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

// // Assert: Check if any error SnackBar is displayed
//     expect(
//         find.byWidgetPredicate(
//           (widget) =>
//               widget is SnackBar && widget.backgroundColor == Colors.red,
//         ),
//         findsOneWidget);
  });

  // testwidget for already registered user
  testWidgets("Register user with already registered email", (tester) async {
    // Arrange: Set up mock behavior for registration failure
    when(mockAuthUseCase.registerUser(any))
        .thenAnswer((_) async => Left(Failure(error: "Email already exists")));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(ref.read(loginViewNavigatorProvider),
                mockAuthUseCase, mockRegisterViewNavigator),
          ),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          home: const RegisterView(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
        find.byType(TextFormField).at(0), 'Shadip Kumar Joshi');
    await tester.enterText(find.byType(TextFormField).at(1), 'Shadip');
    await tester.enterText(find.byType(TextFormField).at(2), '9234567890');
    await tester.enterText(
        find.byType(TextFormField).at(3), 'shadip@shadip.com');
    await tester.enterText(find.byType(TextFormField).at(4), 'password123');
    await tester.enterText(find.byType(TextFormField).at(5), 'password123');

    // Find the Checkbox widget
    final checkboxFinder = find.byType(Checkbox);

    tester.state(find.byType(RegisterView));
    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    // // Assert: Check if any error SnackBar is displayed
//     expect(
//         find.byWidgetPredicate(
//           (widget) =>
//               widget is SnackBar && widget.backgroundColor == Colors.red,
//         ),
//         findsOneWidget);
  });
}
