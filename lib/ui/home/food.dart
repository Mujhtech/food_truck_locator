import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/controllers/food_controller.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/ui/food/create.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/food_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CuisinesScreen extends HookWidget {
  const CuisinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final food = useProvider(foodController);
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
                'My Cuisines',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              if (food.foods != null && food.foods!.isNotEmpty)
                Row(
                  children: const [
                    FoodCard(),
                    SizedBox(
                      width: 10,
                    ),
                    FoodCard()
                  ],
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
