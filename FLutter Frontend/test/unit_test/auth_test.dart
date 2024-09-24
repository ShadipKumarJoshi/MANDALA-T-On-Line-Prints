// STEPS TO TEST AUTH VIEW MODEL

// Step 0: first create void main class
// Step 1:  add dependency of mockito with GenerateNiceMocks
// Step 2: check what auth VM  is dependent on: Usecase and Navigator
// Step 3: dart run build_runner build -d  to generate auth_test.mock.dart file
// node: -d is delete confilcting files
// cannot use provider scope in dart like in flutter , so use ProviderContainer
// override authVMProvider with mock in test file
// setUp() to initialize the mock objects; also dispose the container in tearDown()
// test for initial state of AuthViewModel  ie authState
// snackbar must be commented in testing
// NOTE: AAA in mockito: Arrange, Act, Assert
// Arange : failure case and success case
// Act: call the loginUser() method
// Assert: check for the error in authState

import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<RegisterViewNavigator>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;
  late RegisterViewNavigator mockRegisterViewNavigator;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    mockRegisterViewNavigator = MockRegisterViewNavigator();

    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
        (ref) => AuthViewModel(
            mockLoginViewNavigator, mockAuthUsecase, mockRegisterViewNavigator),
      )
    ]);
  });

  test('check for the inital state in Auth state', () {
    // NOT (ref).read(authViewModelProvider) but container.read(authViewModelProvider) as we are using Container
    // run the test individiually and then write further
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  // TEST 1 ------------- LOGIN TESTS ----------------
  // LOGIN TEST FOR SINGLE USER

  test('login test with valid emailOrPhoneNumber and password', () async {
    // Arrange
    when(mockAuthUsecase.loginUser('shadip@shadip.com', 'shadip123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    when(mockAuthUsecase.loginUser('shadip@shadip.com', 'shadip1234'))
        .thenAnswer(
      (_) => Future.value(
        Left(
          Failure(error: 'Invalid'),
        ),
      ),
    );

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('shadip@shadip.com', 'shadip123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  // LOGIN FOR MULTIPLE USERS
  test('login test with valid emailOrPhoneNumber and password', () async {
    // Arrange
    const correctEmailOrPhoneNumber = 'shadip@shadip.com';
    const correctPassword = 'shadip123';

// NOTE: for (any, any) make auth_usecase (emailOrPhoneNumber and password as nullable wih ?)
// TEST NOTE
// COmment the snackbar in auth_view_model.dart and common

    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          email == correctEmailOrPhoneNumber && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('shadip@shadip.com', 'shadip123');

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  // TEST 2 ------------- REGISTER TESTS ----------------
  test(
    'Register new user test with all details test',
    () async {
      // Arrange
// NOTE: for (any) make auth_usecase (AuthEntity as nullable wih ?)
// COmment the snackbar in auth_view_model.dart and common
      when(mockAuthUsecase.registerUser(any)).thenAnswer((innovation) {
        final auth = innovation.positionalArguments[0] as AuthEntity;

        return Future.value(
          auth.fullname.isNotEmpty &&
                  auth.username.isNotEmpty &&
                  auth.phoneNumber.isNotEmpty &&
                  auth.phoneNumber.length == 10 &&
                  auth.email.isNotEmpty &&
                  auth.email.contains('@') &&
                  auth.email.contains('.') &&
                  auth.password.isNotEmpty
              ? const Right(true)
              : Left(
                  Failure(error: 'Invalid details'),
                ),
        );
      });
      // Act
      await container
          .read(authViewModelProvider.notifier)
          .registerUser(const AuthEntity(
            fullname: 'Test Test',
            username: 'test123',
            phoneNumber: '1234567890',
            email: 'test@test.com',
            password: '12345678',
          ));

      final state = container.read(authViewModelProvider);

      // Assert
      expect(state.isLoading, false);
      expect(state.error, null);
    },
  );

// dispose the container from   provider
  tearDown(
    () {
      container.dispose();
    },
  );
}
