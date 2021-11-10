import 'package:flutter/material.dart';
import 'package:food_truck_locator/models/truck_model.dart';

class TruckSingle extends StatelessWidget {
  final TruckModel item;
  const TruckSingle({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
