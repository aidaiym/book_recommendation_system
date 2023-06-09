import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../files.dart';
import '../logic/profile_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileCubit(),
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/blank-dp.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hi ${AuthenticationService.auth.currentUser!.displayName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to your profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${AuthenticationService.auth.currentUser!.email}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 100,
                  child: CustomButton(
                    label: 'LOGOUT',
                    color: Colors.black,
                    onPressed: () async {
                      LoaderX.show(context);
                      await AuthenticationService.auth.signOut().then((value) {
                        LoaderX.hide();
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.id, (route) => false);
                      });
                    },
                    size: size,
                    textColor: Colors.white,
                    borderSide: BorderSide.none,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
