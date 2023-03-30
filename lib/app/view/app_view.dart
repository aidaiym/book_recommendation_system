import 'package:flutter/material.dart';

import '../../files.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Recommendation App',
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
