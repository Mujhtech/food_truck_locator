import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';

class TruckCreate extends StatelessWidget {
  const TruckCreate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            width: context.screenWidth(1),
            height: 160,
            padding: const EdgeInsets.all(50),
            color: const Color(0xFFEFEFEF),
            child: SizedBox(
                height: 50,
                width: 50,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color(0xFFFFFFFF),
                  ),
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.photo_camera,
                    size: 20,
                    color: Color(0xFFCCCCCC),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 120, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 35,
                                offset: const Offset(0, 25),
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
                            return 'Truck Name Field is required';
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
                          hintText: 'Truck Name',
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
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Location Field is required';
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
                          hintText: 'Location',
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
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Description Field is required';
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
                          hintText: 'About your truck',
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
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (v) {},
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
                          hintText: 'Website',
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
                const SizedBox(
                  height: 20,
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
          )
        ],
      ),
    );
  }
}
