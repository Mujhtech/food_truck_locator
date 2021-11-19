import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  String? userId;
  String? foodOwnerId;
  String? message;
  DateTime? createdAt;
  String? orderId;

  MessageModel(
      {this.userId,
      this.id,
      this.foodOwnerId,
      this.message,
      this.createdAt,
      this.orderId});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      message: json['message'],
      foodOwnerId: json['food_owner_id'],
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  factory MessageModel.fromDocument(doc) {
    final data = doc;
    return MessageModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['food_owner_id'] = foodOwnerId;
    data['order_id'] = orderId;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
