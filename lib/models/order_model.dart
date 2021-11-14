class OrderModel {
  String? id;
  String? userId;
  String? foodOwnerId;

  OrderModel({this.id, this.userId, this.foodOwnerId});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        foodOwnerId: json['food_owner_id'],
        userId: json['user_id'],);
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
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
