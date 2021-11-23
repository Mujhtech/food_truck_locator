import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_truck_locator/controllers/appointment_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatefulWidget {
  final TruckModel item;
  const ReservationScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController information = TextEditingController();
  TextEditingController fulladdress = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime when = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final appointment = watch(appointmentController);
      return Scaffold(
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
              'Make a Reservation',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        Text(
                          'You are one step closer to booking Real Deal Truck for your event, kindly fill in the details below and we will get back to you! Enjoy!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Full Name Field is required';
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
                            hintText: 'Full Name',
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
                              return 'Estimated Number needed Field is required';
                            }
                          },
                          controller: number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                            LengthLimitingTextInputFormatter(11),
                          ],
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
                            hintText: 'Estimated Number needed',
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
                        GestureDetector(
                          onTap: () async {
                            final res = await showDatePicker(
                                context: context,
                                initialDate: when,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                                helpText: 'Select date');
                            setState(() {
                              when = res!;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: context.screenWidth(1),
                            height: 50,
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                  DateFormat.yMMMEd().format(when),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Full Address Field is required';
                            }
                          },
                          controller: fulladdress,
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
                            hintText: 'Full Address',
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
                            RegExp regex = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (v!.isEmpty) {
                              return 'Email Address Field is required';
                            } else if (!regex.hasMatch(v)) {
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
                        TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Phone Number Field is required';
                            }
                          },
                          controller: phoneNumber,
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
                          height: 10,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Additional Information Field is required';
                            }
                          },
                          controller: information,
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
                            hintText: 'Additional Information',
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
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if (!await appointment.create(
                        fullname.text.trim(),
                        email.text.trim(),
                        when,
                        phoneNumber.text.trim(),
                        fulladdress.text.trim(),
                        information.text.trim(),
                        int.parse(number.text.trim()),
                        widget.item.id!,
                        widget.item.userId!,
                        2)) {
                      return;
                    }
                    fulladdress.text = '';
                    email.text = '';
                    phoneNumber.text = '';
                    fullname.text = '';
                    information.text = '';
                    number.text = '';
                    showGeneralDialog(
                      barrierLabel: "Barrier",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: const Duration(milliseconds: 200),
                      context: context,
                      pageBuilder: (_, __, ___) {
                        return Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 283,
                            width: 293,
                            child: SizedBox.expand(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    color:
                                        Commons.primaryColor.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(100),
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
                                            fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    'Your order is reserved. we will get\nback to you shortly.',
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
                                                  const HomeScreen(index: 0,)),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Text(
                                      'Return Home',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 14,
                                              color: Commons.primaryColor),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            margin: const EdgeInsets.only(
                                bottom: 50, left: 12, right: 12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                    height: 53,
                    alignment: Alignment.center,
                    child: Text(
                      'Reserve',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Commons.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
