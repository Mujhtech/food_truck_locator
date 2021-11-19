import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/truck_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final truckController = ChangeNotifierProvider<TruckController>((ref) {
  return TruckController(ref.read)..retrieve();
});

class TruckController extends ChangeNotifier {
  final Reader _read;
  String? error;
  List<TruckModel>? _trucks;
  bool loading = false;

  List<TruckModel>? get trucks => _trucks;

  TruckController(this._read) {
    retrieve();
  }

  TruckModel filterTruckbyId(String id) {
    return _trucks!.firstWhere((truck) => truck.id! == id);
  }

  Set<Marker> maps(customIcon, onClickMarker) {
    Set<Marker> trucks = {};

    if (_trucks!.isNotEmpty) {
      Set<Marker> datas = _trucks!
          .map((e) => Marker(
              onTap: () {
                onClickMarker(e);
              },
              markerId: MarkerId(e.title!),
              icon: customIcon,
              infoWindow: InfoWindow(title: e.title),
              position: LatLng(
                  double.parse(e.latitude!), double.parse(e.longitude!))))
          .toSet();

      trucks.addAll(datas);
    }

    return trucks;
  }

  List<TruckModel> filterTruckByUser(String userId) {
    List<TruckModel> filterTruck = [];
    if (_trucks != null && _trucks!.isNotEmpty) {
      for (final data in _trucks!) {
        if (data.userId == userId) {
          filterTruck.add(data);
        }
      }
    }
    return filterTruck;
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items = await _read(truckRepositoryProvider).get();
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
      String userId,
      String title,
      String description,
      String location,
      String website,
      double latitude,
      double longitude,
      String bannerImage,
      String featuredImage,
      List<String> galleries) async {
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
          userId: userId,
          galleries: galleries,
          createdAt: DateTime.now());
      await _read(truckRepositoryProvider).create(id: id, item: item);
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
      String id,
      String userId,
      String title,
      String description,
      String location,
      String website,
      double latitude,
      double longitude,
      String bannerImage,
      String featuredImage,
      List<String> galleries) async {
    try {
      loading = true;
      notifyListeners();
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
          userId: userId,
          galleries: galleries,
          createdAt: DateTime.now());
      await _read(truckRepositoryProvider).create(id: id, item: item);
      loading = false;
      await retrieve();
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
    //print(imageUrls);
    loading = false;
    notifyListeners();
    return imageUrls;
  }

  Future<String> uploadFile(File _image) async {
    loading = true;
    notifyListeners();
    Reference ref =
        _read(firebaseStorageProvider).ref().child("trucks/" + _image.path);
    UploadTask uploadTask = ref.putFile(_image);
    final result = await uploadTask.then((res) async {
      return await res.ref.getDownloadURL();
    });
    loading = false;
    notifyListeners();
    return result;
  }

  Future<bool> removeImage(String url) async {
    try {
      loading = true;
      notifyListeners();
      Reference ref1 = _read(firebaseStorageProvider).refFromURL(url);
      await ref1.delete();
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
