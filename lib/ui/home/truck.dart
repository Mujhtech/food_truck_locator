import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/truck/create.dart';
import 'package:food_truck_locator/ui/truck/plan.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/truck_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TruckScreen extends HookWidget {
  const TruckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final truck = useProvider(truckController);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Trucks',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              if (truck.trucks != null && truck.trucks!.isNotEmpty)
                const TruckCard(
                  width: 1,
                )
              else
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/NoTruck.svg',
                          color: const Color(0xFFCCCCCC),
                          semanticsLabel: 'Explore'),
                      Text(
                        'There is no information about your\ntruck yet. Start setting up your truck\nright away!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              Column(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TruckCreate()));
                    },
                    elevation: 0,
                    color: Commons.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: context.screenWidth(1),
                      height: 53,
                      alignment: Alignment.center,
                      child: Text(
                        'Add New Truck',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Commons.whiteColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
