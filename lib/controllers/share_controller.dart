import 'package:flutter/material.dart';
import 'package:food_truck_locator/repositories/share_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
