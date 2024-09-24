import 'package:final_assignment/core/common/colors.dart';
import 'package:final_assignment/core/utils/validation.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool? isChecked = false;
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneNumberController = TextEditingController(text: "test1@test.com");
  final _passwordController = TextEditingController(text:"testtest");

  @override
  void dispose() {
    _emailOrPhoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/dashboard_bg.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Rounded edges
              color: goldColor,
            ),
            child: const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
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
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Container(),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/login.png',
                        height: 150,
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Hi!\nWelcome.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Add some space between texts
                    const Center(
                      child: Text(
                        'Please enter your credentials to login!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              color: Color(0xFFFFD700),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.green,
                                  spreadRadius: 10,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailOrPhoneNumberController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      labelText: "Email or Mobile Number",
                                      prefixIcon: const Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      )),
                                  validator: (value) =>
                                      validateEmailOrPhoneNumber(value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _passwordController,
                                  style: const TextStyle(),
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      labelText: "Password",
                                      prefixIcon: const Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      )),
                                  validator: (value) =>
                                      validatePassword(value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isChecked,
                                          activeColor: Colors.blue,
                                          onChanged: (newBool) {
                                            setState(() {
                                              isChecked = newBool;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Remember Me!',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 10,
                                            color: Color(0xff4c505b),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          ref
                                              .read(loginViewModelProvider
                                                  .notifier)
                                              .openForgotPasswordView();
                                          // Navigator.pushReplacement(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (_) =>
                                          //         const ForgotPasswordView(),
                                          //   ),
                                          // );
                                        },
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                        )),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      ref
                                          .read(authViewModelProvider.notifier)
                                          .loginUser(
                                            _emailOrPhoneNumberController.text,
                                            _passwordController.text,
                                          );

                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) => const DashboardView(),
                                      //   ),
                                      // );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(color: Colors.green),
                                const Text(
                                  "Or\nLogin with",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff4c505b),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly, // Evenly space the icons
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        //fb login logic
                                        // print('Login from fb pressed');
                                      },
                                      icon: Image.asset(
                                        'assets/icons/iconFb.ico',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        //google login logic
                                        // print('Login from google pressed');
                                      },
                                      icon: Image.asset(
                                        'assets/icons/iconGoogle.ico',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.green),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "Don't have an account?",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Color(0xff4c505b),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          ref
                                              .read(loginViewModelProvider
                                                  .notifier)
                                              .openRegisterView();
                                        },
                                        child: const Text(
                                          'Create an account!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.blue,
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
