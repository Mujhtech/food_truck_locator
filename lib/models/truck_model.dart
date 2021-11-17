class TruckModel {
  String? id;
  String? title;
  String? description;
  String? plan;
  String? featuredImage;
  String? bannerImage;
  String? location;
  String? latitude;
  String? longitude;
  String? website;
  String? userId;
  List<String>? galleries;

  TruckModel(
      {this.id,
      this.bannerImage,
      this.description,
      this.featuredImage,
      this.plan,
      this.title,
      this.latitude,
      this.location,
      this.longitude,
      this.website,
      this.userId,
      this.galleries});

  factory TruckModel.fromJson(Map<String, dynamic> json) {
    return TruckModel(
        id: json['id'],
        title: json['title'],
        userId: json['user_id'],
        website: json['website'],
        location: json['location'],
        latitude: json['latitude'] ?? '0',
        longitude: json['longitude'] ?? '0',
        plan: json['plan'],
        description: json['description'],
        featuredImage: json['featured_image'],
        bannerImage: json['banner_image'],
        galleries: json['galleries'] != null && json['galleries'].length > 0
            ? json['galleries'].cast<String>()
            : []);
  }

  factory TruckModel.fromDocument(doc) {
    final data = doc;
    return TruckModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['user_id'] = userId;
    data['plan'] = plan;
    data['description'] = description;
    data['website'] = website;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['featured_image'] = featuredImage;
    data['banner_image'] = bannerImage;
    data['galleries'] = galleries;
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
