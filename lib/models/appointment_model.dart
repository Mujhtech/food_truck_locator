import 'package:cloud_firestore/cloud_firestore.dart';

class AppointMentModel {
  int? type;
  String? id;
  String? truckId;
  String? userId;
  String? truckOwnerId;
  String? information;
  String? phoneNumber;
  String? fullname;
  String? email;
  int? number;
  DateTime? date;
  String? address;

  AppointMentModel(
      {this.id,
      this.type,
      this.userId,
      this.truckId,
      this.address,
      this.truckOwnerId,
      this.information,
      this.fullname,
      this.email,
      this.number,
      this.date,
      this.phoneNumber});

  factory AppointMentModel.fromJson(Map<String, dynamic> json) {
    return AppointMentModel(
        type: json['type'],
        id: json['id'],
        userId: json['user_id'],
        truckOwnerId: json['truck_ownwer_id'],
        truckId: json['truck_id'],
        information: json['information'],
        date: (json['date'] as Timestamp).toDate(),
        phoneNumber: json['phone_number'],
        fullname: json['fullname'],
        email: json['email'],
        number: json['number'],
        address: json['address']);
  }

  factory AppointMentModel.fromDocument(doc) {
    final data = doc;
    return AppointMentModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['id'] = id;
    data['truck_owner_id'] = truckOwnerId;
    data['truck_id'] = truckId;
    data['information'] = information;
    data['address'] = address;
    data['fullname'] = fullname;
    data['date'] = date;
    data['email'] = email;
    data['number'] = number;
    data['phone_number'] = phoneNumber;
    data['type'] = type;
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
