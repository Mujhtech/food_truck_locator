import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  String? accountType;
  String? profileImage;
  String? address;
  DateTime? lastLoggedIn;
  DateTime? planExpiredDate;
  DateTime? planStartDate;
  String? planName;
  String? loginType;
  String? fcmToken;

  UserModel(
      {this.email,
      this.fullName,
      this.password,
      this.phoneNumber,
      this.uid,
      this.accountType,
      this.profileImage,
      this.address,
      this.lastLoggedIn,
      this.planExpiredDate,
      this.planName,
      this.loginType,
      this.planStartDate,
      this.fcmToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullName: json['full_name'],
        uid: json['user_id'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        accountType: json['account_type'],
        password: json['password'],
        address: json['contact_address'],
        profileImage: json['profile_picture'],
        planName: json['plan_name'],
        loginType: json['login_type'],
        fcmToken: json['fcm_token'],
        planExpiredDate: (json['plan_expired_date'] as Timestamp).toDate(),
        planStartDate: (json['plan_start_date'] as Timestamp).toDate(),
        lastLoggedIn: json['last_logged_in'] ?? DateTime.now());
  }

  factory UserModel.fromDocument(doc) {
    final data = doc;
    return UserModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['user_id'] = uid;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['account_type'] = accountType;
    data['contact_address'] = address;
    data['profile_picture'] = profileImage;
    data['last_logged_in'] = lastLoggedIn;
    data['plan_start_date'] = planStartDate;
    data['plan_expired_date'] = planExpiredDate;
    data['plan_name'] = planName;
    data['login_type'] = loginType;
    data['fcm_token'] = fcmToken;
    return data;
  }
}
