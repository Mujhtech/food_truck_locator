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
  static const String uid = "uid";
  static const String email = "email";
  static const String password = "password";
  static const String profilePic = "profile_pic";
  static const String theme = "theme";
  static const String linked = 'linked';
  static const String balanceVisibility = 'balance_visibility';

  ShareController(this._read, this.sharedPreferences);


  Future<void> changeBalanceVisibility(bool value) async {
    await _read(sharedUtilityProvider).setBalanceVisibility(value);
    notifyListeners();
  }

  Future<void> changeSystemTheme(int value) async {
    await _read(sharedUtilityProvider).setSystemTheme(value);
    notifyListeners();
  }

  Future<void> linkedAccount(String userId, String email, String password) async {
    await _read(sharedUtilityProvider).setLinkedEmail(email);
    await _read(sharedUtilityProvider).setLinkedUserId(userId);
    await _read(sharedUtilityProvider).setLinkedPassword(password);
    await _read(sharedUtilityProvider).setLinkedStatus(true);
    notifyListeners();
  }

  bool? getLinkAccountStatus(){
    return sharedPreferences!.getBool(linked) ?? false;
  }

  bool? getBalanceVisibility(){
    return sharedPreferences!.getBool(balanceVisibility) ?? true;
  }

  ThemeMode myTheme() {
    if (sharedPreferences!.getInt(theme) == 1) {
      return ThemeMode.light;
    } else if (sharedPreferences!.getInt(theme) == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }
}
