import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/controllers/order_controller.dart';
import 'package:food_truck_locator/controllers/user_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/order_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SingleOrderModal extends StatelessWidget {
  final OrderModel item;
  const SingleOrderModal({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final order = watch(orderControllerProvider);
      final food = watch(foodController);
      final user = watch(userControllerProvider);
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(mainAxisSize: MainAxisSize.min, children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: const Color(0xFFFFFFFF),
                  ),
                  width: 42,
                  height: 42,
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Color(0xFF656565),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: context.screenWidth(1),
                height: 150,
                child: Stack(children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              food.filterFoodbyId(item.foodId!).bannerImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.white
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0, 0.2, 1],
                      ),
                    ),
                  ))
                ])),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 20, top: 20),
                    width: context.screenWidth(1),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ListView(children: [
                      Center(
                        child: Text(
                          food.filterFoodbyId(item.foodId!).title!,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Commons.primaryColor,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Commons.primaryColor.withOpacity(0.1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart,
                                size: 24, color: Commons.primaryColor),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(item.status!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Commons.primaryColor,
                                        fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
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
                                Text(
                                    user.filterUserbyId(item.userId!).fullName!,
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
                                    user.filterUserbyId(item.userId!).email! +
                                        '\n' +
                                        user
                                            .filterUserbyId(item.userId!)
                                            .phoneNumber!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    item.shippingPostalCode! +
                                        ', ' +
                                        item.shippingAddress! +
                                        ', \n' +
                                        item.shippingCity! +
                                        ' ' +
                                        item.shippingCountry!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextFormField(
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
                              hintText: 'Enter message....',
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
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  print(0);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: const BoxDecoration(
                                        color: Commons.primaryColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6))),
                                    child: const Icon(
                                      Icons.send,
                                      color: Commons.whiteColor,
                                    )),
                              ),
                              filled: true,
                            ),
                            autocorrect: false,
                            autofocus: false,
                            obscureText: false,
                          ),
                        ],
                      )
                    ])))
          ]));
    });
  }
}
