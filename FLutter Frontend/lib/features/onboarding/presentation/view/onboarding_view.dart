import 'package:final_assignment/core/common/colors.dart';
import 'package:final_assignment/features/onboarding/presentation/viewmodel/onboarding_view_model.dart';
import 'package:final_assignment/features/onboarding/presentation/widgets/onboarding_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery within the build method to get the height of the screen
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.1,
                      ),
                      child: Column(
                        children: [
                          Text(
                            contents[i].title,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: goldColor,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            contents[i].image,
                            height: 400,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Text(
                              contents[i].description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(onboardingViewModelProvider.notifier)
                          .openLoginView();
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const LoginView(),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: const BorderSide(
                            color: Colors.black), // Black border
                      ),
                      shadowColor: Colors.black,
                      elevation: 5, // Elevation to apply shadow
                    ),
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Next/Continue Button
                  ElevatedButton(
                    onPressed: () {
                      if (currentIndex == contents.length - 1) {
                        ref
                            .read(onboardingViewModelProvider.notifier)
                            .openLoginView();
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => const LoginView(),
                        //   ),
                        // );
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: const BorderSide(
                            color: Colors.black), // Black border
                      ),
                      shadowColor: Colors.black,
                      elevation: 5, // Elevation to apply shadow
                    ),
                    child: Text(
                      currentIndex == contents.length - 1 ? "Continue" : "Next",
                      style: const TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
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

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10, // Fixed height for all dots
      width: currentIndex == index ? 25 : 10, // Wider dot for the current page
      margin: const EdgeInsets.only(right: 5), // Spacing between dots
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Rounded edges
        color: goldColor,
        border: Border.all(
          color: Colors.black, // Black border
          width: 1.0, // Border width
        ),
      ),
    );
  }
}
