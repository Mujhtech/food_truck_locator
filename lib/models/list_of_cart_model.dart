import 'package:food_truck_locator/models/cart_model.dart';

class ListOfCartModel {
  late List<CartModel> data;

  ListOfCartModel({
    required this.data,
  });

  ListOfCartModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      final datas = json["data"];
      final arr0 = <CartModel>[];
      for (final data in datas) {
        arr0.add(CartModel.fromJson(data as Map<String, dynamic>));
      }
      data = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    final v = this.data;
    final arr0 = [];
    for (var v in v) {
      arr0.add(v.toJson());

      data["data"] = arr0;
    }
    return data;
  }
}
