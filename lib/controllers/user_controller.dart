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

  List<UserModel>? get users => _users;

  UserController(this._read) {
    retrieve();
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
