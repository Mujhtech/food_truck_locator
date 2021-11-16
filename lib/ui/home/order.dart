import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/order_controller.dart';
import 'package:food_truck_locator/widgets/order_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final order = watch(orderControllerProvider);
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
                if (order.orders != null && order.orders!.isNotEmpty)
                  Flexible(
                    fit: FlexFit.loose,
                    child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
                        itemCount: order.orders!.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (1 / 1.1),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return const OrderCard();
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
