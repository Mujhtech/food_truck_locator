import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/order_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/order_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orderControllerProvider = ChangeNotifierProvider<OrderController>((ref) {
  final user = ref.watch(authControllerProvider);
  return OrderController(ref.read, user.user?.uid)..retrieve();
});

class OrderController extends ChangeNotifier {
  final Reader _read;
  final String? _userId;
  String? error;
  List<OrderModel>? _orders;
  bool loading = false;

  List<OrderModel>? get orders => _orders;

  OrderController(this._read, this._userId) {
    if (_userId != null) {
      retrieve();
    }
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items = await _read(orderRepositoryProvider).getAll();
      _orders = items;
      loading = false;
      notifyListeners();
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(
    String foodId,
    int qty,
    String truckId,
    String foodOwnerId,
  ) async {
    try {
      loading = true;
      notifyListeners();
      String id =
          _read(firebaseFirestoreProvider).appointment().doc().id.toString();
      OrderModel item = OrderModel(
          id: id,
          qty: qty,
          foodId: foodId,
          foodOwnerId: foodOwnerId,
          userId: _userId);
      await _read(orderRepositoryProvider).create(id: id, item: item);
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
