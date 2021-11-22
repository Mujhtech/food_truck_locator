import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/remote_config_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/services/backend_service.dart';
import 'package:food_truck_locator/ui/truck/confirm.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TruckPlan extends StatefulWidget {
  const TruckPlan({Key? key}) : super(key: key);

  @override
  State<TruckPlan> createState() => _TruckPlanState();
}

class _TruckPlanState extends State<TruckPlan> {
  BackendServices backendServices = BackendServices();
  String? selectedPlan;
  int selectedAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final remote = watch(remoteControllerProvider);
      final auth = watch(authControllerProvider);
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlan = "basic";
                        selectedAmount = remote.getIntVal('basic_price');
                      });
                    },
                    child: Container(
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
                                color: Color(0xFF1B2124),
                                width: 4,
                                style: BorderStyle.solid),
                            left: BorderSide(
                                color: Color(0xFF1B2124),
                                width: 1,
                                style: BorderStyle.solid),
                            right: BorderSide(
                                color: Color(0xFF1B2124),
                                width: 1,
                                style: BorderStyle.solid),
                            bottom: BorderSide(
                                color: Color(0xFF1B2124),
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
                                color: const Color(0xFF1B2124),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Container(
                              height: 12.0,
                              width: 12.0,
                              decoration: BoxDecoration(
                                color: selectedPlan == "basic"
                                    ? const Color(0xFF1B2124)
                                    : Colors.white,
                                border: Border.all(
                                  width: 1.0,
                                  color: selectedPlan == "basic"
                                      ? const Color(0xFF1B2124)
                                      : Colors.white,
                                ),
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
                                'BASIC',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                '${remote.getIntVal('basic_price')}USD',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: const Color(0xFF1B2124),
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Text(remote.getStringVal('basic_text'),
                              style: Theme.of(context).textTheme.bodyText2)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlan = "standard";
                        selectedAmount = remote.getIntVal('standard_price');
                      });
                    },
                    child: Container(
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
                                color: selectedPlan == "standard"
                                    ? const Color(0xFFFFD965)
                                    : Colors.white,
                                border: Border.all(
                                  width: 1.0,
                                  color: selectedPlan == "standard"
                                      ? const Color(0xFFFFD965)
                                      : Colors.white,
                                ),
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
                                'STANDARD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 14),
                              ),
                              Text(
                                '${remote.getIntVal('standard_price')}USD',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: const Color(0xFFFFD965),
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Text(remote.getStringVal('standard_text'),
                              style: Theme.of(context).textTheme.bodyText2)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlan = "premium";
                        selectedAmount = remote.getIntVal('premium_price');
                      });
                    },
                    child: Container(
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
                                color: selectedPlan == "premium"
                                    ? Commons.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                  width: 1.0,
                                  color: selectedPlan == "premium"
                                      ? Commons.primaryColor
                                      : Colors.white,
                                ),
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
                                '${remote.getIntVal('premium_price')}USD',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: Commons.primaryColor,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Text(remote.getStringVal('premium_text'),
                              style: Theme.of(context).textTheme.bodyText2)
                        ],
                      ),
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
                      Text('${selectedAmount}USD',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (selectedAmount == 0 || selectedPlan == null) {
                        const snackBar =
                            SnackBar(content: Text('Please select a plan'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }

                      try {
                        final paymentIntent = await backendServices
                            .getAccessToken(selectedAmount * 100);
                        await Stripe.instance.initPaymentSheet(
                            paymentSheetParameters: SetupPaymentSheetParameters(
                          applePay: true,
                          googlePay: true,
                          style: ThemeMode.dark,
                          testEnv: true,
                          merchantDisplayName: auth.user!.fullName!,
                          paymentIntentClientSecret: paymentIntent,
                        ));

                        await Stripe.instance.presentPaymentSheet();
                        if (selectedPlan! == "premium") {
                          await auth.updatePlan(selectedPlan!, DateTime.now(),
                              DateTime.now().add(const Duration(days: 364)));
                        } else if (selectedPlan! == "standard") {
                          await auth.updatePlan(selectedPlan!, DateTime.now(),
                              DateTime.now().add(const Duration(days: 30)));
                        } else {
                          await auth.updatePlan(
                              selectedPlan!, DateTime.now(), DateTime.now());
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TruckConfirmPayment(
                                      selectedAmount: selectedAmount,
                                      selectedPlan: selectedPlan!,
                                    )),
                            (Route<dynamic> route) => false);
                      } catch (err) {
                        //
                        //print(err.toString());
                        const snackBar =
                            SnackBar(content: Text('Payment has been cancel'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
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
    });
  }
}
