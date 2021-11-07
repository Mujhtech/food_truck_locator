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
  static const String uid = "uid";
  static const String email = "email";
  static const String password = "password";
  static const String profilePic = "profile_pic";
  static const String theme = "theme";
  static const String linked = 'linked';
  static const String onBoarding = "on_boarding";
  static const String balanceVisibility = 'balance_visibility';

  int isDarkModeEnabled() {
    return sharedPreferences!.getInt(theme) ?? 0;
  }

  bool getOnBoardingStatus() {
    return sharedPreferences!.getBool(onBoarding) ?? false;
  }

  Future<bool> setSystemTheme(int value) async {
    return await sharedPreferences!.setInt(theme, value);
  }

  Future<bool> setLinkedEmail(String value) async {
    return await sharedPreferences!.setString(email, value);
  }

  Future<bool> setLinkedPassword(String value) async {
    return await sharedPreferences!.setString(password, value);
  }

  Future<bool> setLinkedUserId(String value) async {
    return await sharedPreferences!.setString(uid, value);
  }
  
  Future<bool> setLinkedStatus(bool value) async {
    return await sharedPreferences!.setBool(linked, value);
  }

  Future<bool> setOnboardingStatus(bool value) async {
    return await sharedPreferences!.setBool(onBoarding, value);
  }

  Future<bool> setBalanceVisibility(bool value) async {
    return await sharedPreferences!.setBool(balanceVisibility, value);
  }
}
