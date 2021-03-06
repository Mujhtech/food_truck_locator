import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/controllers/truck_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/event.dart';
import 'package:food_truck_locator/ui/food/create.dart';
import 'package:food_truck_locator/ui/food/single.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/food_card.dart';
import 'package:food_truck_locator/widgets/modals/search_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CuisinesScreen extends HookWidget {
  const CuisinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final food = useProvider(foodController);
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
                    'My Cuisines',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      InkWell(
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
              const SizedBox(
                height: 10,
              ),
              if (food.filterFoodByUser(auth.user!.uid!).isNotEmpty)
                Flexible(
                  fit: FlexFit.loose,
                  child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
                      itemCount: food.filterFoodByUser(auth.user!.uid!).length,
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
                                    builder: (context) => FoodSingle(
                                        item: food.filterFoodByUser(
                                            auth.user!.uid!)[index])));
                          },
                          child: FoodCard(
                            page: 1,
                            title: food
                                .filterFoodByUser(auth.user!.uid!)[index]
                                .title!,
                            bannerImage: food
                                .filterFoodByUser(auth.user!.uid!)[index]
                                .bannerImage!,
                          ),
                        );
                      }),
                )
              else
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/NoCuisine.svg',
                          color: const Color(0xFFCCCCCC),
                          semanticsLabel: 'Explore'),
                      Text(
                        'There is no information about your\ncuisine yet. Start setting up your cuisine\nright away!',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FoodCreate()));
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
                        'Add New Cuisine',
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
