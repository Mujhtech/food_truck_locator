import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/cart_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/my_order_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String address;
  final String city;
  final String postalCode;
  final String country;
  const OrderConfirmationScreen(
      {Key? key,
      required this.address,
      required this.city,
      required this.country,
      required this.postalCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final cart = watch(cartController);
      final auth = watch(authControllerProvider);
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            title: Text(
              'Order Confirmation',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 60,
                                color: Color(0xFF3CAF47),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Thank You!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                  ),
                                  Text(
                                    'Your order has been placed',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'We sent an email to ${auth.user!.email!} with your order confirmation and bill',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 20,
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
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    postalCode +
                                        ', ' +
                                        address +
                                        ', \n' +
                                        city +
                                        ' ' +
                                        country,
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ],
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
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            width: context.screenWidth(1),
                            decoration:
                                const BoxDecoration(color: Color(0xFFFBFBFB)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              'Order items',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                              size: 20,
                            )
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          ...cart.carts!.data.map((e) => MyOrderCard(item: e)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Order summary',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Summary',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                '${Commons.getTotalAmout(cart.carts != null ? cart.carts!.data : [])}USD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shipping',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                '0USD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                '${Commons.getTotalAmout(cart.carts != null ? cart.carts!.data : [])}USD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            await cart.emptyCart();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()),
                                (Route<dynamic> route) => false);
                          },
                          elevation: 0,
                          color: Commons.primaryColor.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: context.screenWidth(1),
                            height: 56,
                            alignment: Alignment.center,
                            child: Text(
                              'Back to shopping',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Commons.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ])));
    });
  }
}
