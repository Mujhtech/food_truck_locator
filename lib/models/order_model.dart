class OrderModel {
  String? id;
  String? userId;
  String? foodOwnerId;
  String? foodId;
  int? qty;

  OrderModel({this.id, this.userId, this.foodOwnerId, this.qty, this.foodId});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      foodOwnerId: json['food_owner_id'],
      userId: json['user_id'],
      foodId: json['food_id'],
      qty: json['qty'],
    );
  }

  factory OrderModel.fromDocument(doc) {
    final data = doc;
    return OrderModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['food_owner_id'] = foodOwnerId;
    data['user_id'] = userId;
    data['food_id'] = foodId;
    data['qty'] = qty;
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
