import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final remoteControllerProvider = ChangeNotifierProvider<RemoteConfigController>(
    (ref) => RemoteConfigController(ref.read)..init());

class RemoteConfigController extends ChangeNotifier {
  final Reader _read;

  bool notificationStatus = false;
  final defaults = <String, dynamic>{
    'basic_price': 5,
    'standard_price': 10,
    'premium_price': 50,
    'basic_text': 'Lorem Ipsum Lorem\nLorem Ipsum Lorem\nLorem Ipsum Lorem',
    'standard_text': 'Lorem Ipsum Lorem\nLorem Ipsum Lorem\nLorem Ipsum Lorem',
    'premium_text': 'Lorem Ipsum Lorem\nLorem Ipsum Lorem\nLorem Ipsum Lorem',
  };

  RemoteConfigController(this._read);

  Future init() async {
    try {
      await _read(firebaseRemoteConfig).setDefaults(defaults);
      await _read(firebaseRemoteConfig).setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 2),
        minimumFetchInterval: const Duration(seconds: 2),
      ));
      await _read(firebaseRemoteConfig).fetchAndActivate();
    } catch (err) {
      //print(err.toString());
    }
  }

  bool getBoolVal(String key) {
    return _read(firebaseRemoteConfig).getBool(key);
  }

  String getStringVal(String key) {
    return _read(firebaseRemoteConfig).getString(key);
  }

  int getIntVal(String key) {
    return _read(firebaseRemoteConfig).getInt(key);
  }
}
