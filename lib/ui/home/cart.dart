import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Shopping Cart',
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
                    Text('Arrives in 24 Hours',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Commons.primaryColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const CartCard(),
              const CartCard(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
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
                      onPressed: () async {},
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
                          'Checkout',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Commons.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
