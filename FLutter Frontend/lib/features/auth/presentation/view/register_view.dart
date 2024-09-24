import 'package:final_assignment/core/common/colors.dart';
import 'package:final_assignment/core/utils/validation.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/register_view_model.dart';
import 'package:final_assignment/features/auth/presentation/widgets/user_agreement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  bool? isChecked = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _key = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showUserAgreementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("User Agreement"),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text(userAgreement),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isChecked = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text(
                "I have read the User Agreement",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/dashboard_bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: goldColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // AuthEntity auth=AuthEntity(fullname: fullname, username: username, phoneNumber: phoneNumber, email: email, password: password)
                // ref.read(registerViewModelProvider.notifier).openLoginView();

                ref.read(registerViewModelProvider.notifier).openLoginView();
                //----------------------

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => const LoginView(),
                //   ),
                // );
              },
            ),
            centerTitle: true,
            title: const Text(
              'Register',
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/register.png',
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
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Please enter your details to register!',
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
                    top: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: goldColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.green,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _fullNameController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Full Name",
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  validator: (value) =>
                                      validateFullName(value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _usernameController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Username",
                                    prefixIcon: const Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  validator: (value) =>
                                      validateUsername(value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _phoneNumberController,
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Phone Number",
                                    prefixIcon: const Icon(Icons.phone),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  validator: (value) =>
                                      validatePhoneNumber(value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _emailController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Email",
                                    prefixIcon: const Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  validator: (value) =>
                                      validateEmail(value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _passwordController,
                                  style: const TextStyle(),
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Password",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  validator: (value) =>
                                      validatePassword(value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  style: const TextStyle(),
                                  obscureText: !_isConfirmPasswordVisible,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: "Confirm Password",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isConfirmPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmPasswordVisible =
                                              !_isConfirmPasswordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  validator: (value) => validateConfirmPassword(
                                      _passwordController.text, value ?? ''),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Checkbox(
                                            value: isChecked,
                                            activeColor: Colors.blue,
                                            onChanged: (newBool) {
                                              setState(() {
                                                isChecked = newBool;
                                              });
                                            },
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: _showUserAgreementDialog,
                                          child: const Text(
                                            'I agree to the User Agreement.',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 10,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      if (isChecked == true) {
                                        var user = AuthEntity(
                                          fullname: _fullNameController.text,
                                          username: _usernameController.text,
                                          phoneNumber: _phoneNumberController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );

                                        ref
                                            .read(
                                                authViewModelProvider.notifier)
                                            .registerUser(user);

                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   const SnackBar(
                                        //     content: Text(
                                        //         'Congratulation! Your account is successfully created. Login again to access your account.'),
                                        //     backgroundColor: Colors.green,
                                        //   ),
                                        // );

                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (_) =>
                                        //         const LoginView(),
                                        //   ),
                                        // );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please agree to the User Agreement.'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(color: Colors.green),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account?",
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
                                            .read(registerViewModelProvider
                                                .notifier)
                                            .openLoginView();
                                        // Navigator.pushReplacement(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (_) => const LoginView(),
                                        //   ),
                                        // );
                                      },
                                      child: const Text(
                                        'Login here!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
