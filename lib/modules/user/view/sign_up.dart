import 'package:flutter/material.dart';

import '../../../files.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Open an account with a few details.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: '******',
                    obscureText: true,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    controller: _passwordController,
                    validator: (value) =>
                        Validator.validatePassword(value ?? ""),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    label: 'CREATE YOUR ACCOUNT',
                    color: const Color(0xff6200EE),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        LoaderX.show(context);
                        final status = await _authService.createAccount(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        );

                        if (status == AuthStatus.successful) {
                          LoaderX.hide();
                          Navigator.pushNamed(context, UserInformation.id);
                        } else {
                          LoaderX.hide();
                          final error =
                              AuthExceptionHandler.generateErrorMessage(status);
                          CustomSnackBar.showErrorSnackBar(
                            context,
                            message: error,
                          );
                        }
                      }
                    },
                    size: size,
                    textColor: Colors.white,
                    borderSide: BorderSide.none,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _authService.signInWithGoogle().then((value) {
                        Navigator.pushNamed(context, UserInformation.id);
                      });
                    },
                    child: const Text('Sign In with Google'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: RichText(
                      textScaleFactor: 0.8,
                      text: const TextSpan(
                        text: "Do you already have an acccount? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign in here',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}
