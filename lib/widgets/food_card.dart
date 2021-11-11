import 'package:flutter/material.dart';
import 'package:food_truck_locator/utils/constant.dart';

class FoodCard extends StatelessWidget {
  final int page;
  final String title;
  final String bannerImage;
  const FoodCard(
      {Key? key,
      required this.bannerImage,
      required this.title,
      required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: 165,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(bannerImage), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Container(
            width: 200,
            height: 25,
            decoration: BoxDecoration(
                color:
                    page == 2 ? Commons.primaryColor : const Color(0xFFECECFE),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color:
                        page == 2 ? Commons.whiteColor : Commons.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
