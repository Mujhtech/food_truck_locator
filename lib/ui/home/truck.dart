import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/event.dart';
import 'package:food_truck_locator/ui/truck/create.dart';
import 'package:food_truck_locator/ui/truck/plan.dart';
import 'package:food_truck_locator/ui/truck/single.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/modals/search_modal.dart';
import 'package:food_truck_locator/widgets/truck_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TruckScreen extends HookWidget {
  const TruckScreen({Key? key}) : super(key: key);

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    final truck = useProvider(truckController);
    final auth = useProvider(authControllerProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Trucks',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EventScreen()));
                        },
                        child: Container(
                            height: 47,
                            width: 47,
                            decoration: const BoxDecoration(
                                color: Color(0xFFFBFBFB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Icon(
                              Icons.event,
                              size: 20,
                              color: Color(0xFF656565),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => showCupertinoModalBottomSheet(
                            elevation: 0,
                            expand: true,
                            shadow: const BoxShadow(color: Colors.transparent),
                            backgroundColor: Colors.transparent,
                            transitionBackgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => SearchModal(
                                  trucks: truck.trucks!,
                                )),
                        child: Container(
                            height: 47,
                            width: 47,
                            decoration: const BoxDecoration(
                                color: Color(0xFFFBFBFB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Icon(
                              Icons.search,
                              size: 20,
                              color: Color(0xFF656565),
                            )),
                      ),
                    ],
                  )
                ],
              ),
              if (truck.filterTruckByUser(auth.user!.uid!).isNotEmpty)
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TruckSingle(
                                            item: truck.filterTruckByUser(
                                                auth.user!.uid!)[index],
                                          )));
                            },
                            child: TruckCard(
                              title: truck
                                  .filterTruckByUser(auth.user!.uid!)[index]
                                  .title!,
                              bannerImage: truck
                                  .filterTruckByUser(auth.user!.uid!)[index]
                                  .bannerImage!,
                              width: 1,
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemCount:
                          truck.filterTruckByUser(auth.user!.uid!).length),
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
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (auth.user!.planName == "basic") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TruckPlan()));
                      } else if (auth.user!.planName == "standard" &&
                          daysBetween(
                                  DateTime.now(), auth.user!.planExpiredDate!) <
                              0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TruckPlan()));
                      } else if (auth.user!.planName == "premium" &&
                          daysBetween(
                                  DateTime.now(), auth.user!.planExpiredDate!) <
                              0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TruckPlan()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TruckCreate()));
                      }
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
                    height: 10,
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
