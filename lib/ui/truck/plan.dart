import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/truck/card.dart';
import 'package:food_truck_locator/utils/constant.dart';

class TruckPlan extends StatelessWidget {
  const TruckPlan({Key? key}) : super(key: key);

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
          'Select a plan',
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
              children: [
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
                            color: Color(0xFFFFD965),
                            width: 4,
                            style: BorderStyle.solid),
                        left: BorderSide(
                            color: Color(0xFFFFD965),
                            width: 1,
                            style: BorderStyle.solid),
                        right: BorderSide(
                            color: Color(0xFFFFD965),
                            width: 1,
                            style: BorderStyle.solid),
                        bottom: BorderSide(
                            color: Color(0xFFFFD965),
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
                            width: 1.0,
                            color: const Color(0xFFFFD965),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          height: 12.0,
                          width: 12.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD965),
                            border: Border.all(
                              width: 1.0,
                              color: const Color(0xFFFFD965),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'BASIC',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14),
                          ),
                          Text(
                            '5USD',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    color: const Color(0xFFFFD965),
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
                  height: 30,
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                        ),
                        child: Container(
                          height: 12.0,
                          width: 12.0,
                          decoration: BoxDecoration(
                            color: Commons.primaryColor,
                            border: Border.all(
                                width: 1.0, color: Commons.primaryColor),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
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
              ],
            ),
            Row(
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
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TruckCardPayment()));
                  },
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
          ],
        ),
      ),
    );
  }
}
