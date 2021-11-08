import 'package:flutter/material.dart';
import 'package:food_truck_locator/utils/constant.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 160,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Food111.png'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Container(
            width: 160,
            height: 25,
            decoration: const BoxDecoration(
                color: Color(0xFFECECFE),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Center(
              child: Text(
                'Fish and Chips',
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
