import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../files.dart';

class MainView extends StatefulWidget {
  static const String id = 'main';
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _controller = PageController(initialPage: 0);

  final _items = const [
    BookScreen(),
    HomeScreen(),
  ];

  Future<void> _change(BuildContext context, int val) async {
    await _controller.animateToPage(
      val,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    // ignore: use_build_context_synchronously
    context.read<MainCubit>().change(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
          onPageChanged: context.read<MainCubit>().change,
          controller: _controller,
          itemBuilder: (context, index) => _items[index],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xff6200EE),
            currentIndex: context.read<MainCubit>().state,
            type: BottomNavigationBarType.fixed,
            items: [
              _buildNavBar(0, Icons.home),
              _buildNavBar(1, Icons.person),
            ],
            onTap: (val) => _change(context, val),
          ),
        ));
  }

  BottomNavigationBarItem _buildNavBar(int index, IconData icon) {
    return BottomNavigationBarItem(
      label: '',
      icon: BlocBuilder<MainCubit, int>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CircleAvatar(
              backgroundColor:
                  state == index ? Colors.white : const Color(0xff6200EE),
              child: Icon(
                icon,
                color: state == index ? const Color(0xff6200EE) : Colors.white,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
