import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/order_confirm.dart';
import 'package:food_truck_locator/ui/shipping.dart';
import 'package:food_truck_locator/utils/constant.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

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
          'Secure Payment',
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
                        'Delivery',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ShippingScreen()));
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
                              'Add Delivery Address',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            ),
                            const Icon(Icons.arrow_forward,
                                size: 20, color: Color(0xFF656565))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Text(
                        'Payment',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.credit_card,
                        color: Colors.black,
                        size: 20,
                      )
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Credit/Debit Card',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Card Number Field is required';
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
                        hintText: 'Card Number',
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
                          return 'Expiry Date Field is required';
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
                        hintText: 'Expiry Date',
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
                          return 'CVV Field is required';
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
                        hintText: 'CVV',
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
                          return 'Card Name Field is required';
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
                        hintText: 'Card Name',
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
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 12)),
                        Text('USD150.00',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OrderConfirmationScreen()));
                      },
                      elevation: 0,
                      color: Commons.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: context.screenWidth(0.5),
                        height: 56,
                        alignment: Alignment.center,
                        child: Text(
                          'Pay Now',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Commons.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ])),
    );
  }
}
