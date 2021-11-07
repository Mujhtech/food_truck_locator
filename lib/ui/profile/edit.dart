import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/user_profile_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final auth = watch(authControllerProvider);
      fullname.text = auth.user!.fullName!;
      email.text = auth.user!.email!;
      address.text = auth.user!.address!;
      phone.text = auth.user!.phoneNumber!;
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: InkWell(
                              onTap: () {},
                              child: UserProfileImage(
                                radius: 138,
                                image: auth.user!.profileImage,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Fullname Field is required';
                            }
                          },
                          controller: fullname,
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
                          height: 20,
                        ),
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
                          height: 20,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Phone Number Field is required';
                            }
                          },
                          controller: phone,
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
                          height: 20,
                        ),
                        TextFormField(
                          validator: (p) {
                            if (p!.isEmpty) {
                              return 'Address Field is required';
                            }
                          },
                          controller: address,
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
                            hintText: 'Address',
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
                      ],
                    ),
                  )),
              const SizedBox(
                height: 40,
              ),
              if (auth.loading)
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Commons.primaryColor)),
                )
              else
                Center(
                  child: MaterialButton(
                    hoverElevation: 0,
                    elevation: 0,
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      if (!await auth.updateUser(
                        fullname.text.trim(),
                        email.text.trim(),
                        address.text.trim(),
                        phone.text.trim(),
                      )) {
                        const snackBar =
                            SnackBar(content: Text('Save successfully'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      Navigator.pop(context);
                    },
                    color: Commons.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: context.screenWidth(1),
                      height: 53,
                      alignment: Alignment.center,
                      child: Text(
                        'Save',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Commons.whiteColor),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
