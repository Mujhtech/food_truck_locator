import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/order_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderCard extends StatelessWidget {
  final OrderModel item;
  const OrderCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final food = watch(foodController);
      return Container(
        padding: const EdgeInsets.all(10),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.filterFoodbyId(item.foodId!).title!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.w600)),
                    Text(food.filterFoodbyId(item.foodId!).title!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 12)),
                  ],
                ),
                Text('${food.filterFoodbyId(item.foodId!).amount!}USD',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  width: 130,
                  height: 104,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              food.filterFoodbyId(item.foodId!).bannerImage!))),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text('QTY',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.w600)),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFFF2F2F2),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: Row(
                          children: [
                            Text('${item.qty}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                          ],
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: const Color(0xFFFBFBFB),
              //height: 148,
              padding: const EdgeInsets.all(10),
              width: context.screenWidth(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Banu Elson',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('orders@banuelson.com\n+49 179 111 1010',
                      style: Theme.of(context).textTheme.bodyText2),
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
                      style: Theme.of(context).textTheme.bodyText2)
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
