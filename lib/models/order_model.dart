class OrderModel {
  String? id;
  String? userId;
  String? foodOwnerId;
  String? foodId;
  int? qty;
  String? shippingPostalCode;
  String? shippingAddress;
  String? shippingCity;
  String? shippingCountry;
  String? status;
  int? rating;
  String? comment;

  OrderModel(
      {this.id,
      this.userId,
      this.foodOwnerId,
      this.qty,
      this.foodId,
      this.shippingPostalCode,
      this.shippingCountry,
      this.shippingCity,
      this.shippingAddress,
      this.comment,
      this.rating,
      this.status});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      foodOwnerId: json['food_owner_id'],
      userId: json['user_id'],
      foodId: json['food_id'],
      qty: json['qty'],
      shippingAddress: json['shipping_address'],
      shippingCity: json['shipping_city'],
      shippingCountry: json['shipping_country'],
      shippingPostalCode: json['shipping_postal_code'],
      rating: json['rating'],
      comment: json['comment'],
      status: json['status'],
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
    data['shipping_address'] = shippingAddress;
    data['shipping_city'] = shippingCity;
    data['shipping_country'] = shippingCountry;
    data['shipping_postal_code'] = shippingPostalCode;
    data['comment'] = comment;
    data['rating'] = rating;
    data['status'] = status;
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
