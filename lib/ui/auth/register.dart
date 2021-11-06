import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account',
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
                  'Sign Up',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Kindly fill in the information below',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Fullname Field is required';
                    }
                  },
                  cursorColor: Commons.primaryColor,
                  keyboardType: TextInputType.text,
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
                    hintText: 'Fullname',
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
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Phone Number Field is required';
                    }
                  },
                  cursorColor: Commons.primaryColor,
                  keyboardType: TextInputType.number,
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
                    hintText: 'Phone Number',
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
                      'Sign Up',
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
                      'Sign up later',
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
