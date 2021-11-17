import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/truck_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final truckController = ChangeNotifierProvider<TruckController>((ref) {
  final user = ref.watch(authControllerProvider);
  return TruckController(ref.read, user.user?.uid)..retrieve();
});

class TruckController extends ChangeNotifier {
  final Reader _read;
  final String? _userId;
  String? error;
  List<TruckModel>? _trucks;
  bool loading = false;

  List<TruckModel>? get trucks => _trucks;

  TruckController(this._read, this._userId) {
    if (_userId != null) {
      retrieve();
    }
  }

  TruckModel filterTruckbyId(String id) {
    return _trucks!.firstWhere((truck) => truck.id! == id);
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items = await _read(truckRepositoryProvider).get(userId: _userId!);
      _trucks = items;
      loading = false;
      notifyListeners();
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(
      String title,
      String description,
      String location,
      String website,
      double latitude,
      double longitude,
      String bannerImage,
      String featuredImage) async {
    try {
      loading = true;
      notifyListeners();
      String id = _read(firebaseFirestoreProvider).truck().doc().id.toString();
      TruckModel item = TruckModel(
          id: id,
          title: title,
          description: description,
          plan: 'premium',
          location: location,
          bannerImage: bannerImage,
          featuredImage: featuredImage,
          website: website,
          latitude: '$latitude',
          longitude: '$longitude',
          userId: _userId);
      await _read(truckRepositoryProvider).create(id: id, item: item);
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
    var imageUrls =
        await Future.wait(_images.map((_image) => uploadFile(_image)));
    //print(imageUrls);
    return imageUrls;
  }

  Future<String> uploadFile(File _image) async {
    Reference ref =
        _read(firebaseStorageProvider).ref().child("trucks/" + _image.path);
    UploadTask uploadTask = ref.putFile(_image);
    final result = await uploadTask.then((res) async {
      return await res.ref.getDownloadURL();
    });

    return result;
  }
}
