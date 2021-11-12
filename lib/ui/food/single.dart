import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/models/food_model.dart';
import 'package:food_truck_locator/ui/home.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:food_truck_locator/widgets/modals/order_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FoodSingle extends StatelessWidget {
  final FoodModel item;
  const FoodSingle({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(children: [
          Container(
              width: context.screenWidth(1),
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFEFEFEF),
                image: DecorationImage(
                    image: NetworkImage(item.bannerImage!), fit: BoxFit.cover),
              ),
              padding: const EdgeInsets.all(50),
              child: Container()),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: const Color(0xFFFFFFFF),
                        ),
                        width: 42,
                        height: 42,
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Color(0xFF656565),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF000000).withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                        width: 105,
                        height: 105,
                        child: SvgPicture.asset(
                          'assets/images/User.svg',
                          width: 200,
                          height: 200,
                          color: const Color(0xFF656565),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      item.title!,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Commons.primaryColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Text(item.description!,
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              MaterialButton(
                                onPressed: () => showCupertinoModalBottomSheet(
                                  elevation: 0,
                                  expand: true,
                                  backgroundColor: Colors.transparent,
                                  transitionBackgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => OrderModal(
                                    item: item,
                                  ),
                                ),
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
                                    'Order Now',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Commons.whiteColor),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomeScreen()),
                                              (Route<dynamic> route) => false);
                                },
                                elevation: 0,
                                color: Commons.primaryColor.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  width: context.screenWidth(1),
                                  height: 53,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Find Food Truck in my street',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Commons.primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]))
        ]));
  }
}