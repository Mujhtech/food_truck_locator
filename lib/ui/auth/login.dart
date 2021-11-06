import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/auth/register.dart';
import 'package:food_truck_locator/ui/home.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                },
                child: Text(
                  'Don’t have an account?',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Commons.primaryColor),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () async {},
              elevation: 0,
              color: Commons.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: context.screenWidth(1),
                height: 53,
                alignment: Alignment.center,
                child: Text(
                  'Continue with Google',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Commons.whiteColor),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 34,
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF000000),
                  ),
                ),
                Text(
                  'Or',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  width: 34,
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF000000),
                  ),
                )
              ],
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  validator: (e) {
                    if (e!.isEmpty) {
                      return 'Email Field is required';
                    }
                  },
                  cursorColor: Commons.primaryColor,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14),
                  decoration: InputDecoration(
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.border,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.border,
                    focusedErrorBorder:
                        Theme.of(context).inputDecorationTheme.border,
                    hintText: 'Email Address',
                    hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                    errorBorder: Theme.of(context).inputDecorationTheme.border,
                    errorStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    filled: true,
                  ),
                  autocorrect: false,
                  autofocus: false,
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (p) {
                    if (p!.isEmpty) {
                      return 'Password Field is required';
                    }
                  },
                  cursorColor: Commons.primaryColor,
                  keyboardType: TextInputType.visiblePassword,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14),
                  decoration: InputDecoration(
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.border,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.border,
                    focusedErrorBorder:
                        Theme.of(context).inputDecorationTheme.border,
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                    errorBorder: Theme.of(context).inputDecorationTheme.border,
                    errorStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    filled: true,
                  ),
                  autocorrect: false,
                  autofocus: false,
                  obscureText: true,
                ),
              ],
            )),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                MaterialButton(
                  onPressed: () async {},
                  elevation: 0,
                  color: Commons.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: context.screenWidth(1),
                    height: 53,
                    alignment: Alignment.center,
                    child: Text(
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Commons.whiteColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (Route<dynamic> route) => false);
                  },
                  elevation: 0,
                  color: Commons.primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: context.screenWidth(1),
                    height: 53,
                    alignment: Alignment.center,
                    child: Text(
                      'Sign in later',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Commons.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
