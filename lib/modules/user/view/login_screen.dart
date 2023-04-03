import 'package:flutter/material.dart';

import '../../../files.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        body: SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox(height: 70)),
                const Text(
                  'Зайдите в свой аккаунт',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Email address',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'abc@example.com',
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
                  hintText: '********',
                  obscureText: true,
                  // keyboardType: TextInputType.number,
                  maxLength: 20,
                  controller: _passwordController,
                  textCapitalization: TextCapitalization.none,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, ResetPasswordScreen.id),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 0.0),
                  ),
                  child: const Text(
                    'Восстановить.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                CustomButton(
                  label: 'Войти',
                  color: const Color(0xff6200EE),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      LoaderX.show(context);
                      final status = await _authService.login(
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                      );

                      if (status == AuthStatus.successful) {
                        LoaderX.hide();
                        if (AuthenticationService.auth.currentUser!.email ==
                            'omurbekovnaaidaiym@gmail.com') {
                          Navigator.pushNamed(context, AdminDash.id);
                        } else {
                          Navigator.pushNamed(context, MainView.id);
                        }
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
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, SignUpScreen.id),
                  child: const Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
