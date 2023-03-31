import 'package:flutter/material.dart';

import 'files.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainView.id:
        return MaterialPageRoute(builder: (_) => const MainView());
      case SignUpScreen.id:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case ResetPasswordScreen.id:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case HomeScreen.id:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case BookScreen.id:
        return MaterialPageRoute(builder: (_) => const BookScreen());
      case UserInformation.id:
        return MaterialPageRoute(builder: (_) => const UserInformation());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Something went wrong')),
                ));
    }
  }
}
