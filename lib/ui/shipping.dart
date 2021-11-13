import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          'Add Shipping Address',
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Recipents Information',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.local_shipping,
                        color: Colors.black,
                        size: 20,
                      )
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Full Address Field is required';
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
                        hintText: 'Full Address',
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
                      height: 20,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'City Field is required';
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
                        hintText: 'City',
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
                      height: 20,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Country Field is required';
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
                        hintText: 'Country',
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
                      height: 20,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Postal Code Field is required';
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
                        hintText: 'Postal Code',
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
                    Row(children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all<Color>(
                            Commons.primaryColor),
                        checkColor: Colors.white,
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Use for default delivery address',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ]),
                  ],
                )),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
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
              ])),
    );
  }
}
