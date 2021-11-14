import 'package:flutter/material.dart';
import 'package:food_truck_locator/models/food_model.dart';
import 'package:food_truck_locator/repositories/share_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final shareControllerProvider = ChangeNotifierProvider<ShareController>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return ShareController(ref.read, sharedPrefs);
});

class ShareController extends ChangeNotifier {
  final Reader _read;
  final SharedPreferences? sharedPreferences;
  static const String cart = "cart";
  static const String mapPermission = "map_permission";
  List? carts;

  ShareController(this._read, this.sharedPreferences);

  Future<void> addToCart(int qty, FoodModel item) async {
    List data = [];
    if (sharedPreferences!.getString(cart) == null) {
      Map<String, dynamic> food = {
        'id': item.id,
        'data': item.toJson(),
        'qty': qty
      };
      //final encodeData = data.add(food);
      //await _read(sharedUtilityProvider).setCart(jsonEncode(encodeData));
      //print(data.add(food));
    } else {
      //print(0);
    }
  }

  Future<void> updateCart(String value) async {
    await _read(sharedUtilityProvider).setCart(value);
    notifyListeners();
  }

  String? getCart() {
    return sharedPreferences!.getString(cart) ?? '';
  }

  Future<void> updateMapPermission(bool value) async {
    await _read(sharedUtilityProvider).setMapPermission(value);
    notifyListeners();
  }

  bool? getMapPermission() {
    return sharedPreferences!.getBool(mapPermission) ?? false;
  }
}
