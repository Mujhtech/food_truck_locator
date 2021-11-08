import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/screen_extension.dart';
import 'package:food_truck_locator/utils/constant.dart';

class TruckCard extends StatelessWidget {
  final double width;
  const TruckCard({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: context.screenWidth(width),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Truck111.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Container(
            width: context.screenWidth(width),
            height: 25,
            decoration: const BoxDecoration(
                color: Color(0xFFECECFE),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Center(
              child: Text(
                'Real Deal Trucks',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Commons.primaryColor, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
