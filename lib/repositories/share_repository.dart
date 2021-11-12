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

  Future<bool> setCart(String value) async {
    return await sharedPreferences!.setString(cart, value);
  }
}
