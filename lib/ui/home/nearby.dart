import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/ui/truck/single.dart';
import 'package:food_truck_locator/widgets/truck_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final truck = watch(truckController);
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
                  'Near By',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                if (truck.trucks != null && truck.trucks!.isNotEmpty)
                  Flexible(
                    fit: FlexFit.loose,
                    child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
                        itemCount: truck.trucks!.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (1 / 1.1),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TruckSingle(
                                              item: truck.trucks![index],
                                            )));
                              },
                              child: TruckCard(
                                title: truck.trucks![index].title!,
                                bannerImage: truck.trucks![index].bannerImage!,
                                width: 0.5,
                              ));
                        }),
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
                          'No truck find near by',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
