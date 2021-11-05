import 'package:flutter/material.dart';
import 'package:food_truck_locator/utils/constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'Don’t have an account?',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Commons.primaryColor),
              ),
            ),
            Text(
              'Sign In',
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              'Welcome, sign in to continue',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      )),
    );
  }
}
