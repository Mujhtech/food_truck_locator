import 'package:food_truck_locator/models/food_model.dart';

class CartModel {
  String? id;
  FoodModel? item;
  int? qty;

  CartModel({
    this.id,
    this.item,
    this.qty,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(id: json['id'], item: json['item'], qty: json['qty']);
  }

  factory CartModel.fromDocument(doc) {
    final data = doc;
    return CartModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['id'] = id;
    data['item'] = item;
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
