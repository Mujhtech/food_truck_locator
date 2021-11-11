import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FoodCreate extends StatefulWidget {
  const FoodCreate({Key? key}) : super(key: key);

  @override
  State<FoodCreate> createState() => _FoodCreateState();
}

class _FoodCreateState extends State<FoodCreate> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final food = watch(foodController);
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Container(
              width: context.screenWidth(1),
              height: 160,
              padding: const EdgeInsets.all(50),
              color: const Color(0xFFEFEFEF),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    //padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: const Color(0xFFFFFFFF),
                    ),
                    width: 50,
                    height: 50,
                    child: const Center(
                      child: Icon(
                        Icons.photo_camera,
                        size: 20,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Form(
                      key: formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.05),
                                      spreadRadius: 0,
                                      blurRadius: 5,
                                      offset: const Offset(0, 0),
                                    ),
                                  ]),
                              width: 105,
                              height: 105,
                              child: SvgPicture.asset(
                                'assets/images/User.svg',
                                width: 200,
                                height: 200,
                                color: const Color(0xFF656565),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Add Details',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Cuisine Name Field is required';
                              }
                            },
                            controller: title,
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
                              hintText: 'Cuisine Name',
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
                          TextFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'About Field is required';
                              }
                            },
                            controller: description,
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
                              hintText: 'About',
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
                            maxLines: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Add Images',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 100,
                            width: context.screenWidth(1),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              border: Border.all(
                                  width: 1,
                                  color: const Color(0xFFCCCCCC),
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Text(
                                'Browse',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Commons.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      if (food.loading)
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
                        MaterialButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            if (!await food.create(
                                title.text.trim(), description.text.trim())) {
                              return;
                            }
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
                                            Icons.check,
                                            color: Commons.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            'Successful',
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
                                        Center(
                                          child: Text(
                                            'Your cuisine has been addedd\nsuccessfully',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(fontSize: 14),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomeScreen()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            },
                                            child: Text(
                                              'Return Home',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          Commons.primaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                    margin: const EdgeInsets.only(
                                        bottom: 50, left: 12, right: 12),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(16),
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
                          elevation: 0,
                          color: Commons.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: context.screenWidth(1),
                            height: 56,
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
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
