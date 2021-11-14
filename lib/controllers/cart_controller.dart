import 'package:flutter/material.dart';
import 'package:food_truck_locator/models/cart_model.dart';
import 'package:food_truck_locator/models/food_model.dart';
import 'package:food_truck_locator/models/list_of_cart_model.dart';
import 'package:food_truck_locator/repositories/share_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cartController = ChangeNotifierProvider<CartController>((ref) {
  return CartController(ref.read)..retrieve();
});

class CartController extends ChangeNotifier {
  final Reader _read;
  String? error;
  ListOfCartModel? _carts;

  bool loading = false;

  ListOfCartModel? get carts => _carts;
  CartController(this._read) {
    retrieve();
  }

  void retrieve() {
    final data = _read(sharedUtilityProvider).loadSharedCartData();
    _carts = data;
    notifyListeners();
  }

  void saveData() {
    _read(sharedUtilityProvider).saveSharedCartData(_carts!);
  }

  void add(FoodModel item, int qty) {
    _carts = ListOfCartModel(data: [
      ..._carts!.data,
      CartModel(id: item.id, item: item, qty: qty),
    ]);
    saveData();
  }

  void edit({required FoodModel item, required int qty}) {
    _carts = ListOfCartModel(data: [
      for (final cart in _carts!.data)
        if (cart.id == item.id)
          CartModel(id: cart.id, qty: qty, item: item)
        else
          cart,
    ]);
    saveData();
  }

  void remove(FoodModel item) {
    _carts = ListOfCartModel(
        data: _carts!.data.where((cart) => cart.id != item.id).toList());

    saveData();
  }
}
