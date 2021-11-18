import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/food_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/food_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final foodController = ChangeNotifierProvider<FoodController>((ref) {
  return FoodController(ref.read)..retrieve();
});

class FoodController extends ChangeNotifier {
  final Reader _read;
  String? error;
  List<FoodModel>? _foods;
  bool loading = false;

  List<FoodModel>? get foods => _foods;

  FoodController(this._read) {
    retrieve();
  }

  List<FoodModel> filterFoodByTruck(String id) {
    List<FoodModel> filterFood = [];
    if (_foods != null && foods!.isNotEmpty) {
      for (final data in _foods!) {
        if (data.truckId == id) {
          filterFood.add(data);
        }
      }
    }
    return filterFood;
  }

  FoodModel filterFoodbyId(String id) {
    return _foods!.firstWhere((food) => food.id! == id);
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items = await _read(foodRepositoryProvider).get();
      _foods = items;
      loading = false;
      notifyListeners();
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(
      String userId,
      String truckId,
      String title,
      String description,
      int price,
      String featuredImage,
      String bannerImage,
      List<String> galleries) async {
    try {
      loading = true;
      notifyListeners();
      String id = _read(firebaseFirestoreProvider).food().doc().id.toString();
      FoodModel item = FoodModel(
          truckId: truckId,
          amount: price,
          id: id,
          title: title,
          description: description,
          bannerImage: bannerImage,
          featuredImage: featuredImage,
          galleries: galleries,
          userId: userId);
      await _read(foodRepositoryProvider).create(id: id, item: item);
      loading = false;
      retrieve();
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> update(
      String userId, String title, String description, int price) async {
    try {
      loading = true;
      notifyListeners();
      String id = _read(firebaseFirestoreProvider).food().doc().id.toString();
      FoodModel item = FoodModel(
          amount: price,
          id: id,
          title: title,
          description: description,
          bannerImage: '',
          featuredImage: '',
          userId: userId);
      await _read(foodRepositoryProvider).update(id: id, item: item);
      loading = false;
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<List<String>> uploadFiles(List<File> _images) async {
    loading = true;
    notifyListeners();
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    loading = false;
    notifyListeners();
    return imageUrls;
  }

  Future<String> uploadFile(File _image) async {
    loading = true;
    notifyListeners();
    Reference ref =
        _read(firebaseStorageProvider).ref().child("foods/" + _image.path);
    UploadTask uploadTask = ref.putFile(_image);
    final result = await uploadTask.then((res) async {
      return await res.ref.getDownloadURL();
    });
    loading = false;
    notifyListeners();
    return result;
  }
}
