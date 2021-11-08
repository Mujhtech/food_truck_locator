import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/food_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/food_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final foodController = ChangeNotifierProvider<FoodController>((ref) {
  final user = ref.watch(authControllerProvider);
  return FoodController(ref.read, user.user?.uid)..retrieve();
});

class FoodController extends ChangeNotifier {
  final Reader _read;
  final String? _userId;
  String? error;
  List<FoodModel>? _foods;
  bool loading = false;

  List<FoodModel>? get foods => _foods;

  FoodController(this._read, this._userId) {
    if (_userId != null) {
      retrieve();
    }
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items = await _read(foodRepositoryProvider).get(userId: _userId!);
      _foods = items;
      loading = false;
      notifyListeners();
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(String title, String description, String location) async {
    try {
      loading = true;
      notifyListeners();
      String id = _read(firebaseFirestoreProvider).food().doc().id.toString();
      FoodModel item = FoodModel(
          id: id,
          title: title,
          description: description,
          bannerImage: '',
          featuredImage: '',
          userId: _userId);
      await _read(foodRepositoryProvider).create(id: id, item: item);
      loading = false;
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
