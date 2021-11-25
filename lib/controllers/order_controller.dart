import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/cart_model.dart';
import 'package:food_truck_locator/models/order_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/order_repository.dart';
import 'package:food_truck_locator/services/backend_service.dart';
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
  List<OrderModel>? _myorders;
  bool loading = false;
  BackendServices backendServices = BackendServices();

  List<OrderModel>? get orders => _orders;
  List<OrderModel>? get myorders => _myorders;

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

  List<OrderModel> filterFoodByTruck(String userId) {
    List<OrderModel> filterOrder = [];
    if (_orders != null && _orders!.isNotEmpty) {
      for (final data in _orders!) {
        if (data.foodOwnerId == userId) {
          filterOrder.add(data);
        }
      }
    }
    return filterOrder;
  }

  Future<bool> create(List<CartModel> items, String city, String address,
      String country, String postal) async {
    try {
      loading = true;
      List<OrderModel> myorder = [];
      notifyListeners();
      for (final data in items) {
        String id =
            _read(firebaseFirestoreProvider).order().doc().id.toString();
        OrderModel item = OrderModel(
            id: id,
            qty: data.qty,
            foodId: data.id,
            foodOwnerId: data.item!.userId,
            userId: _userId,
            shippingAddress: address,
            shippingCity: city,
            shippingCountry: country,
            shippingPostalCode: postal,
            rating: 0,
            comment: '',
            status: 'Pending');

        await _read(orderRepositoryProvider).create(id: id, item: item);
        myorder.add(item);
      }
      loading = false;
      _myorders = myorder;
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update(
      String id, String status, String userId, String foodOwnerId) async {
    try {
      loading = true;
      notifyListeners();
      await _read(orderRepositoryProvider).update(id: id, status: status);
      loading = false;
      retrieve();
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> addFeedback(String id, String comment, int rating) async {
    try {
      loading = true;
      notifyListeners();
      await _read(orderRepositoryProvider)
          .feedback(id: id, comment: comment, rating: rating);
      loading = false;
      retrieve();
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
