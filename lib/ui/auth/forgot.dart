import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/connectivity_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final auth = watch(authControllerProvider);
      final connect = watch(connectivityControllerProvider);
      return WillPopScope(
        onWillPop: () async => !auth.loading,
        child: Scaffold(
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
                      if (auth.loading) {
                        return;
                      }
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
                      'Forgot Password',
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
                Flexible(
                  child: Form(
                      key: formKey,
                      child: ListView(
                        shrinkWrap: true,
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
                              hintStyle:
                                  const TextStyle(color: Color(0xFFAAAAAA)),
                              errorBorder:
                                  Theme.of(context).inputDecorationTheme.border,
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.red),
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              filled: true,
                            ),
                            autocorrect: false,
                            autofocus: false,
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
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
                            const snackBar = SnackBar(
                                content: Text('No internet connection'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          if (!await context
                              .read(authControllerProvider)
                              .forgotPassword(email.text.trim())) {
                            final snackBar =
                                SnackBar(content: Text(auth.error!));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            return;
                          }
                          email.text = '';
                          const snackBar = SnackBar(
                              content: Text(
                                  'Check your mail to reset your password'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                            'Forgot Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Commons.whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
