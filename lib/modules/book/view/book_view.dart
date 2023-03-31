import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  static const String id = 'book_screen';

  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Books')),
    );
  }
}
