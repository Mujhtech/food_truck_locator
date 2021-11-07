import 'package:flutter/material.dart';
import 'package:food_truck_locator/utils/constant.dart';

class CartCard extends StatelessWidget {
  const CartCard({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/Pizza.png',
                height: 104,
                width: 130,
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
                          Text('-',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Commons.primaryColor)),
                          const SizedBox(
                            width: 15,
                          ),
                          Text('3',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                          const SizedBox(
                            width: 15,
                          ),
                          Text('+',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Commons.primaryColor))
                        ],
                      ))
                ],
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Commons.primaryColor.withOpacity(0.1),
                  ),
                  child: Text('-',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Commons.primaryColor)))
            ],
          )
        ],
      ),
    );
  }
}
