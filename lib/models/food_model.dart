class FoodModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? featuredImage;
  String? bannerImage;
  String? truckId;

  FoodModel({
    this.id,
    this.userId,
    this.bannerImage,
    this.description,
    this.featuredImage,
    this.truckId,
    this.title,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
        id: json['id'],
        userId: json['user_id'],
        title: json['title'],
        truckId: json['truck_id'],
        description: json['description'],
        featuredImage: json['featured_image'],
        bannerImage: json['banner_image']);
  }

  factory FoodModel.fromDocument(doc) {
    final data = doc;
    return FoodModel.fromJson(data);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['truck_id'] = truckId;
    data['description'] = description;
    data['featured_image'] = featuredImage;
    data['banner_image'] = bannerImage;
    return data;
  }

  Map<String, dynamic> toDocument() => toJson();
}
