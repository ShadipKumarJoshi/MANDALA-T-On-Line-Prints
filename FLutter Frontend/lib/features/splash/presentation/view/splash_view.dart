import 'package:final_assignment/features/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

// Use the SplashViewModel, and navigation
class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    ref.read(splashViewModelProvider.notifier).openLoginView();

    super.initState();

    // this function is now in splash_view_model.dart
    // Timer(const Duration(seconds: 10), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const OnbordingScreen()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.2),
                    child: SizedBox(
                      height: 400,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/images/splash.gif',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'version. 1.0.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
