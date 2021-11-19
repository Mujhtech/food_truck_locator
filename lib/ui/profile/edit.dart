import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/connectivity_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/user_profile_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final auth = watch(authControllerProvider);
      final connect = watch(connectivityControllerProvider);
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
                              onTap: () {
                                showGeneralDialog(
                                  barrierLabel: "Barrier",
                                  barrierDismissible: true,
                                  barrierColor: Colors.black.withOpacity(0.5),
                                  transitionDuration:
                                      const Duration(milliseconds: 200),
                                  context: context,
                                  pageBuilder: (_, __, ___) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 283,
                                        width: 293,
                                        child: SizedBox.expand(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 75,
                                              width: 75,
                                              decoration: BoxDecoration(
                                                color: Commons.primaryColor
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Icon(
                                                Icons.photo_camera,
                                                color: Commons.primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                'Change profile picture',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            if (auth.loading)
                                              const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Commons
                                                                .primaryColor)),
                                              )
                                            else
                                              Column(
                                                children: [
                                                  Center(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        if (!await Commons
                                                            .checkStoragePermission()) {
                                                          if (!await Commons
                                                              .requestStoragePermission()) {
                                                            return;
                                                          }
                                                        }
                                                        try {
                                                          final XFile? image =
                                                              await _picker.pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                          if (image!.name
                                                                  .isNotEmpty &&
                                                              await auth
                                                                  .uploadProfileImage(
                                                                      File(image
                                                                          .path))) {
                                                            return;
                                                          } else {
                                                            return;
                                                          }
                                                        } catch (err) {
                                                          //print(err.toString());
                                                        }
                                                      },
                                                      child: Text(
                                                        'Choose from gallery',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Center(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        if (!await Commons
                                                            .checkCameraPermission()) {
                                                          if (!await Commons
                                                              .requestCameraPermission()) {
                                                            return;
                                                          }
                                                        }
                                                        try {
                                                          final XFile? image =
                                                              await _picker.pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
                                                          if (image!.name
                                                                  .isNotEmpty &&
                                                              await auth
                                                                  .uploadProfileImage(
                                                                      File(image
                                                                          .path))) {
                                                            return;
                                                          } else {
                                                            return;
                                                          }
                                                        } catch (err) {
                                                          //print(err.toString());
                                                        }
                                                      },
                                                      child: Text(
                                                        'Choose from camera',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        )),
                                        margin: const EdgeInsets.only(
                                            bottom: 50, left: 12, right: 12),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                    );
                                  },
                                  transitionBuilder: (_, anim, __, child) {
                                    return SlideTransition(
                                      position: Tween(
                                              begin: const Offset(0, 1),
                                              end: const Offset(0, 0))
                                          .animate(anim),
                                      child: child,
                                    );
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: UserProfileImage(
                                      radius: 138,
                                      image: auth.user!.profileImage,
                                    ),
                                  ),
                                  Positioned(
                                    right: 100,
                                    top: 100,
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Commons.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: const Icon(
                                        Icons.photo_camera,
                                        color: Color(0xFF656565),
                                      ),
                                    ),
                                  ),
                                ],
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
                      if (!connect.connectivityStatus) {
                        const snackBar =
                            SnackBar(content: Text('No internet connection'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
