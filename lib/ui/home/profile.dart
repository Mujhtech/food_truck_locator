import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/profile/edit.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/user_profile_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final auth = watch(authControllerProvider);
      if (auth.user != null) {
        email.text = auth.user!.email!;
        phone.text = auth.user!.phoneNumber!;
      }
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Center(
                      child: UserProfileImage(
                        radius: 180,
                        image: auth.user!.profileImage!,
                      ),
                    ),
                    Text(auth.user!.fullName!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontWeight: FontWeight.w900, fontSize: 32)),
                    const SizedBox(
                      height: 10,
                    ),
                    if (auth.user!.address != null)
                      Text(auth.user!.address!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Commons.primaryColor,
                                  fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: context.screenWidth(1),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(
                              color: const Color(0xFFCCCCCC),
                              width: 1,
                              style: BorderStyle.solid)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Merchant/Vendor Mode',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14),
                          ),
                          Switch(
                              activeColor: Commons.primaryColor,
                              value: auth.user!.accountType! == 'merchant'
                                  ? true
                                  : false,
                              onChanged: (v) async {
                                final value = v ? 'merchant' : 'user';
                                if (await auth.updateAccountType(value)) {
                                  const snackBar = SnackBar(
                                      content:
                                          Text('Account update successfully'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              })
                        ],
                      ),
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
                      readOnly: true,
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
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await auth.signOut();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: context.screenWidth(1),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: const Color(0xFFCCCCCC),
                                width: 1,
                                style: BorderStyle.solid)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Logout',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            ),
                            const Icon(Icons.logout,
                                color: Commons.primaryColor)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileEditScreen()));
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
                          'Edit Profile',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Commons.whiteColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
