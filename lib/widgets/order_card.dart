import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Text('Burger King Burger',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w600)),
                  Text('Full Burger',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 12)),
                ],
              ),
              Text('USD67',
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
              Image.asset(
                'assets/images/Pizza.png',
                height: 104,
                width: 130,
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
                          Text('3',
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
                    'Leibnizstraße 16, Wohnheim 6, No: 8X \nClausthal-Zellerfeld, Germany',
                    style: Theme.of(context).textTheme.bodyText2)
              ],
            ),
          )
        ],
      ),
    );
  }
}
