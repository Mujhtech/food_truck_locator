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

  UserModel(
      {this.email,
      this.fullName,
      this.password,
      this.phoneNumber,
      this.uid,
      this.accountType,
      this.profileImage,
      this.address,
      this.lastLoggedIn});

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
    return data;
  }
}
