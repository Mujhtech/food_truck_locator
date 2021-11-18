import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/auth/register.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final auth = watch(authControllerProvider);
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
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {},
                elevation: 0,
                color: Commons.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        color: Commons.primaryColor, width: 1)),
                child: SizedBox(
                  width: context.screenWidth(1),
                  height: 53,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Container(
                        height: 50,
                        width: 80,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                            )),
                        child: Center(
                          child: Image.asset(
                            'assets/images/Google.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: context.screenWidth(0.675),
                        decoration: const BoxDecoration(
                            color: Commons.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Center(
                          child: Text(
                            'Continue with Google',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Commons.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {},
                elevation: 0,
                color: Commons.whiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                        color: Commons.primaryColor, width: 1)),
                child: SizedBox(
                  width: context.screenWidth(1),
                  height: 53,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Container(
                        height: 50,
                        width: 80,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                            )),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/Apple.svg',
                            width: 30,
                            height: 30,
                            color: const Color(0xFF656565),
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: context.screenWidth(0.675),
                        decoration: const BoxDecoration(
                            color: Commons.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Center(
                          child: Text(
                            'Continue with Apple',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Commons.whiteColor),
                          ),
                        ),
                      ),
                    ],
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
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (e) {
                          RegExp regex = RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                          if (e!.isEmpty) {
                            return 'Email Address Field is required';
                          } else if (!regex.hasMatch(e)) {
                            return 'Email address is not valid';
                          }
                        },
                        controller: email,
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
                          errorBorder:
                              Theme.of(context).inputDecorationTheme.border,
                          errorStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.red),
                          fillColor:
                              Theme.of(context).inputDecorationTheme.fillColor,
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
                        controller: password,
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
                          errorBorder:
                              Theme.of(context).inputDecorationTheme.border,
                          errorStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.red),
                          fillColor:
                              Theme.of(context).inputDecorationTheme.fillColor,
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
              if (auth.loading)
                const Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Commons.primaryColor)),
                  ),
                )
              else
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        if (!await context
                            .read(authControllerProvider)
                            .signIn(email.text.trim(), password.text.trim())) {
                          final snackBar = SnackBar(content: Text(auth.error!));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (Route<dynamic> route) => false);
                      },
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
    });
  }
}
