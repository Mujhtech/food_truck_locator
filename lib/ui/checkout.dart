import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_truck_locator/controllers/cart_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/shipping.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController postal = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final cart = watch(cartController);
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
                  Expanded(
                    child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
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
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: context.screenWidth(1),
                              height: 50,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  border: Border.all(
                                      color: const Color(0xFFCCCCCC),
                                      width: 1,
                                      style: BorderStyle.solid)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pay on delivery',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                              controller: address,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'Full Address',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
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
                                  return 'City Field is required';
                                }
                              },
                              controller: city,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'City',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
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
                                  return 'Country Field is required';
                                }
                              },
                              controller: country,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'Country',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
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
                                  return 'Postal Code Field is required';
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]+')),
                                LengthLimitingTextInputFormatter(6),
                              ],
                              controller: postal,
                              cursorColor: Commons.primaryColor,
                              keyboardType: TextInputType.number,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                              decoration: InputDecoration(
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
                                hintText: 'Postal Code',
                                hintStyle:
                                    const TextStyle(color: Color(0xFFAAAAAA)),
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .border,
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
                          ],
                        )),
                  ),
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
                          Text(
                              '${Commons.getTotalAmout(cart.carts != null ? cart.carts!.data : [])}USD',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShippingScreen(
                                      country: country.text.trim(),
                                      postalCode: postal.text.trim(),
                                      address: address.text.trim(),
                                      city: city.text.trim())));
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
    });
  }
}
