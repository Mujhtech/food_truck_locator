import 'package:flutter/material.dart';
import 'package:food_truck_locator/models/user_model.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userControllerProvider = ChangeNotifierProvider<UserController>((ref) {
  return UserController(ref.read)..retrieve();
});

class UserController extends ChangeNotifier {
  final Reader _read;
  String? error;
  List<UserModel>? _users;
  bool loading = false;
  String? token;

  List<UserModel>? get users => _users;

  UserController(this._read) {
    retrieve();
  }

  UserModel filterUserbyId(String userId) {
    return _users!.firstWhere((e) {
      return e.uid! == userId;
    });
  }

  bool searchSocialUserbyEmail(String email, String type) {
    bool user = false;

    if (_users!.isNotEmpty) {
      for (final data in _users!) {
        if (data.email! == email && data.loginType == type) {
          user = true;
          break;
        }
      }
    }

    return user;
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items = await _read(userRepositoryProvider).get();
      _users = items;
      loading = false;
      notifyListeners();
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
    }
  }
}
