import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/order_controller.dart';
import 'package:food_truck_locator/widgets/modals/single_order_modal.dart';
import 'package:food_truck_locator/widgets/order_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final order = watch(orderControllerProvider);
      final auth = watch(authControllerProvider);
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'Orders',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Column(
              children: [
                if (order.filterFoodByTruck(auth.user!.uid!).isNotEmpty)
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.separated(
                        itemCount: order.orders!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                            child: Divider(
                              color: Color(0xFFFBFBFB),
                              thickness: 3,
                            ),
                          );
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => showCupertinoModalBottomSheet(
                              elevation: 0,
                              expand: true,
                              shadow:
                                  const BoxShadow(color: Colors.transparent),
                              backgroundColor: Colors.transparent,
                              transitionBackgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => SingleOrderModal(
                                item: order
                                    .filterFoodByTruck(auth.user!.uid!)[index],
                              ),
                            ),
                            child: OrderCard(
                                item: order
                                    .filterFoodByTruck(auth.user!.uid!)[index]),
                          );
                        }),
                  )
                else
                  Center(
                    child: Text(
                      'No order found',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
