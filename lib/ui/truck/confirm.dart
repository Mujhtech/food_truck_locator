import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/truck/create.dart';
import 'package:food_truck_locator/utils/constant.dart';

class TruckConfirmPayment extends StatelessWidget {
  const TruckConfirmPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'Order Confirmation',
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'We sent an email to example@email.com with your order confirmation and bill',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: context.screenWidth(1),
                        height: 103,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: const Border(
                              top: BorderSide(
                                  color: Commons.primaryColor,
                                  width: 4,
                                  style: BorderStyle.solid),
                              left: BorderSide(
                                  color: Commons.primaryColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              right: BorderSide(
                                  color: Commons.primaryColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                              bottom: BorderSide(
                                  color: Commons.primaryColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              height: 24.0,
                              width: 24.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    width: 1.0, color: Commons.primaryColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                              ),
                              child: Container(
                                height: 12.0,
                                width: 12.0,
                                decoration: BoxDecoration(
                                  color: Commons.primaryColor,
                                  border: Border.all(
                                      width: 1.0, color: Commons.primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'PREMUIM',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 14),
                                ),
                                Text(
                                  '10USD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          color: Commons.primaryColor,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Text(
                                'Lorem Ipsum Lorem\nLorem Ipsum Lorem\nLorem Ipsum Lorem',
                                style: Theme.of(context).textTheme.bodyText2)
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
                      Text(
                        'Credit/Debit Card',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 65,
                        width: context.screenWidth(1),
                        decoration:
                            const BoxDecoration(color: Color(0xFFFBFBFB)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Order summary',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                            '150USD',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 16),
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
                            '150USD',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  MaterialButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TruckCreate()));
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
                        'Back to My Trucks',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Commons.primaryColor),
                      ),
                    ),
                  ),
                ])));
  }
}
