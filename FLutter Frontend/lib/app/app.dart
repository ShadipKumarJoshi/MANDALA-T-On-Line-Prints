import 'package:final_assignment/app/navigator_key/navigator_key.dart';
import 'package:final_assignment/features/auth/presentation/view/login_view.dart';
import 'package:final_assignment/features/splash/presentation/view/splash_view.dart';
import 'package:final_assignment/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

// Statelesswidget changed to ConsumerWidget
class App extends ConsumerWidget {
  const App({super.key});

  @override
  // Add WidgetRef ref
  Widget build(BuildContext context, WidgetRef ref) {
    return KhaltiScope(
        publicKey: "test_public_key_0800545e039d45368cab4d1b2fb93d01",
        navigatorKey: AppNavigator.navigatorKey,
        builder: (context, navigator) => MaterialApp(
              navigatorKey: navigator,
              debugShowCheckedModeBanner: false,
              theme: getApplicationTheme(),
              home: const SplashView(),
              // home: const LoginView(),
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],

              // home: ProfileView(),
              // home: const DashboardView(),

              // themes// this method is not used now/ we use navigatorkey

              // home: const SplashView(),
              // home: LoginScreen(),
              // home: RegisterScreen(),
              // home: OnbordingScreen(),
              // routes: {
              //       'login': (context) => LoginScreen(),
              // 'register': (context) => RegisterScreen(),
              // home: DashboardScreen(),
              // },
            ));
  }
}
