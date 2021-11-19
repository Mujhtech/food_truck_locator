import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/connectivity_controller.dart';
import 'package:food_truck_locator/controllers/user_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/auth/register.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final auth = watch(authControllerProvider);
      final user = watch(userControllerProvider);
      final connect = watch(connectivityControllerProvider);
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
                onPressed: () async {
                  try {
                    final GoogleSignInAccount? googleUser =
                        await GoogleSignIn().signIn();

                    if (user.searchSocialUserbyEmail(googleUser!.email)) {
                      const snackBar = SnackBar(
                          content: Text(
                              'Email Address has been used by another person'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    } else {
                      final GoogleSignInAuthentication? googleAuth =
                          await googleUser.authentication;

                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken,
                      );

                      if (!await auth.googleSignIn(credential)) {
                        final snackBar = SnackBar(content: Text(auth.error!));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (Route<dynamic> route) => false);
                      }
                    }
                  } catch (err) {
                    //print(err.toString());
                  }
                },
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
              if (Platform.isIOS)
                MaterialButton(
                  onPressed: () async {
                    final rawNonce = generateNonce();
                    final nonce = sha256ofString(rawNonce);
                    try {
                      final credential =
                          await SignInWithApple.getAppleIDCredential(
                        scopes: [
                          AppleIDAuthorizationScopes.email,
                          AppleIDAuthorizationScopes.fullName,
                        ],
                        nonce: nonce,
                      );

                      final oauthCredential =
                          OAuthProvider("apple.com").credential(
                        idToken: credential.identityToken,
                        rawNonce: rawNonce,
                      );

                      if (credential.email == null) {
                        const snackBar = SnackBar(
                            content:
                                Text('Enable share with email to continue'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }

                      if (user.searchSocialUserbyEmail(credential.email!)) {
                        const snackBar = SnackBar(
                            content: Text(
                                'Email Address has been used by another person'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }

                      if (!await auth.appleSignIn(oauthCredential)) {
                        final snackBar = SnackBar(content: Text(auth.error!));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (Route<dynamic> route) => false);
                      }
                    } catch (err) {
                      //print(err.toString());
                    }
                  },
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
                        if (!connect.connectivityStatus) {
                          const snackBar =
                              SnackBar(content: Text('No internet connection'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
