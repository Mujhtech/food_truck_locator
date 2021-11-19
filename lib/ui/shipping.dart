import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/cart_controller.dart';
import 'package:food_truck_locator/controllers/order_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/order_confirm.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShippingScreen extends StatefulWidget {
  final String address;
  final String city;
  final String postalCode;
  final String country;
  const ShippingScreen(
      {Key? key,
      required this.address,
      required this.city,
      required this.country,
      required this.postalCode})
      : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final cart = watch(cartController);
      final order = watch(orderControllerProvider);
      final auth = watch(authControllerProvider);
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
            'Confirm Shipping Address',
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
                      Container(
                        color: const Color(0xFFFBFBFB),
                        height: 148,
                        padding: const EdgeInsets.all(10),
                        width: context.screenWidth(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(auth.user!.fullName!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                auth.user!.email! +
                                    '\n' +
                                    auth.user!.phoneNumber!,
                                style: Theme.of(context).textTheme.bodyText2),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                widget.postalCode +
                                    ', ' +
                                    widget.address +
                                    ', \n' +
                                    widget.city +
                                    ' ' +
                                    widget.country,
                                style: Theme.of(context).textTheme.bodyText2)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
                      Container(
                        color: const Color(0xFFFBFBFB),
                        height: 65,
                        padding: const EdgeInsets.all(10),
                        width: context.screenWidth(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pay on delivery',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                          ],
                        ),
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
                          Text(
                              '${Commons.getTotalAmout(cart.carts != null ? cart.carts!.data : [])}USD',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      if (order.loading)
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
                            if (!await order.create(
                                cart.carts!.data,
                                widget.city,
                                widget.address,
                                widget.country,
                                widget.postalCode)) {
                              return;
                            }
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderConfirmationScreen(
                                          address: widget.address,
                                          city: widget.city,
                                          postalCode: widget.postalCode,
                                          country: widget.country,
                                        )),
                                (Route<dynamic> route) => false);
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
                              'Confirm',
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
