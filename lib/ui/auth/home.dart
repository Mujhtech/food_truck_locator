import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/ui/auth/login.dart';
import 'package:food_truck_locator/ui/auth/welcome.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final user = watch(authControllerProvider);
        switch (user.status) {
          case Status.unauthenticated:
            return const LoginScreen();
          case Status.authenticating:
            return const WelcomeScreen();
          case Status.authenticated:
            return const HomeScreen(index: 0,);
          case Status.uninitialized:
          default:
            return const WelcomeScreen();
        }
      },
    );
  }
}
