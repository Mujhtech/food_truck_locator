import 'dart:convert';

import 'package:food_truck_locator/models/list_of_cart_model.dart';
import 'package:food_truck_locator/utils/constant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final _sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: _sharedPrefs);
});

class SharedUtility {
  SharedUtility({
    this.sharedPreferences,
  });
  final SharedPreferences? sharedPreferences;
  static const String cart = "cart";
  static const String mapPermission = "map_permission";

  Future<bool> setCart(String value) async {
    return await sharedPreferences!.setString(cart, value);
  }

  Future<bool> setMapPermission(bool value) async {
    return await sharedPreferences!.setBool(mapPermission, value);
  }

  ListOfCartModel loadSharedCartData() {
    Map<String, dynamic> decodeOptions = jsonDecode(
        sharedPreferences!.getString(Commons.sharedPrefCartListKey) ??
            Commons.emptyJsonStringData);
    ListOfCartModel listOfTodoModel = ListOfCartModel.fromJson(decodeOptions);
    return listOfTodoModel;
  }

  void saveSharedCartData(ListOfCartModel listOfCartModel) {
    if (listOfCartModel.data.isNotEmpty) {
      Map<String, dynamic> decodeOptions = listOfCartModel.toJson();
      String sharedData = jsonEncode(
        ListOfCartModel.fromJson(decodeOptions),
      );
      sharedPreferences!.setString(Commons.sharedPrefCartListKey, sharedData);
    } else {
      sharedPreferences!.setString(
          Commons.sharedPrefCartListKey, Commons.emptyJsonStringData);
    }
  }
}
