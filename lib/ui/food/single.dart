import 'package:flutter/material.dart';
import 'package:food_truck_locator/models/food_model.dart';

class FoodSingle extends StatelessWidget {
  final FoodModel item;
  const FoodSingle({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
