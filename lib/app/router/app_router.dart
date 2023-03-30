import 'package:flutter/cupertino.dart';

import '../../files.dart';

class AppRouter {
  const AppRouter();

  static const String main = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String books = '/books';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return CupertinoPageRoute(
          builder: (_) => const MainView(),
          settings: settings,
        );
      case signIn:
        return CupertinoPageRoute(
          builder: (_) => const AuthView(),
          settings: settings,
        );
      case signUp:
        return CupertinoPageRoute(
          builder: (_) => const RegistrationView(),
          settings: settings,
        );
      default:
        throw Exception(
            'no builder specified for route named: [${settings.name}]');
    }
  }
}
