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

  Future<void> retrieve() async {
    final data = _read(sharedUtilityProvider).loadSharedCartData();
    _carts = data;
    notifyListeners();
  }

  Future<void> saveData() async {
    _read(sharedUtilityProvider).saveSharedCartData(_carts!);
  }

  Future<bool> add(FoodModel item, int qty) async {
    if (_carts!.data.isEmpty) {
      _carts = ListOfCartModel(data: [
        ..._carts!.data,
        CartModel(qty: qty, id: item.id, item: item)
      ]);
      saveData();
      notifyListeners();
      return true;
    } else {
      if (checkIfCartAvailable(item.id!)) {
        await edit(item: item, qty: qty);
      } else {
        for (final cart in _carts!.data) {
          if (cart.id != item.id) {
            _carts = ListOfCartModel(data: [
              ..._carts!.data,
              CartModel(qty: qty, id: item.id, item: item)
            ]);
            saveData();
            notifyListeners();
            break;
          }
        }
      }

      return true;
    }
  }

  bool checkIfCartAvailable(String id) {
    bool answer = false;

    for (final cart in _carts!.data) {
      if (cart.id == id) {
        answer = true;
        break;
      }
    }

    return answer;
  }

  Future<void> edit({required FoodModel item, required int qty}) async {
    _carts = ListOfCartModel(data: [
      for (final cart in _carts!.data)
        if (cart.id == item.id)
          CartModel(id: cart.id, qty: qty, item: item)
        else
          cart,
    ]);
    saveData();
    notifyListeners();
  }

  Future<void> remove(FoodModel item) async {
    _carts = ListOfCartModel(
        data: _carts!.data.where((cart) => cart.id != item.id).toList());

    saveData();
    notifyListeners();
  }

  Future<void> emptyCart() async {
    _carts = ListOfCartModel(data: []);
    saveData();
    notifyListeners();
  }
}
