import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/cart_controller.dart';
import 'package:food_truck_locator/models/cart_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartCard extends StatelessWidget {
  final CartModel item;
  const CartCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final myCart = watch(cartController);
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
                    Text('${item.item!.title}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.w600)),
                    Text('${item.item!.title}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 12)),
                  ],
                ),
                Text('${item.item!.amount}USD',
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 130,
                  height: 104,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              item.item!.bannerImage!))),
                ),
                Column(
                  children: [
                    Text('QTY',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.w600)),
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFFF2F2F2),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                myCart.edit(
                                    item: item.item!, qty: item.qty! - 1);
                              },
                              child: Text('-',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Commons.primaryColor)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text('${item.qty}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                            const SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                myCart.edit(
                                    item: item.item!, qty: item.qty! + 1);
                              },
                              child: Text('+',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Commons.primaryColor)),
                            )
                          ],
                        ))
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    myCart.remove(item.item!);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Commons.primaryColor.withOpacity(0.1),
                      ),
                      child: Text('-',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Commons.primaryColor))),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
