import 'package:flutter/material.dart';

import '../../files.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Welcome! Here you can plunge into the world of books!',
              style: TextStyle(
                  color: Color(0xff6200EE),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuthView()),
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    ));
  }
}
