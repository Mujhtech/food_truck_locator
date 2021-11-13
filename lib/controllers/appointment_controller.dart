import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/auth_controller.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/appointment_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/appointment_repository.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appointmentController =
    ChangeNotifierProvider<AppointmentController>((ref) {
  final user = ref.watch(authControllerProvider);
  return AppointmentController(ref.read, user.user?.uid)..retrieve();
});

class AppointmentController extends ChangeNotifier {
  final Reader _read;
  final String? _userId;
  String? error;
  List<AppointMentModel>? _appointments;
  bool loading = false;

  List<AppointMentModel>? get appointments => _appointments;

  AppointmentController(this._read, this._userId) {
    if (_userId != null) {
      retrieve();
    }
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items =
          await _read(appointmentRepositoryProvider).get(userId: _userId!);
      _appointments = items;
      loading = false;
      notifyListeners();
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(
      String fullname,
      String email,
      DateTime date,
      String phoneNumber,
      String address,
      String information,
      int number,
      String truckId,
      String truckOwnerId) async {
    try {
      loading = true;
      notifyListeners();
      String id =
          _read(firebaseFirestoreProvider).appointment().doc().id.toString();
      AppointMentModel item = AppointMentModel(
          id: id,
          fullname: fullname,
          phoneNumber: phoneNumber,
          email: email,
          information: information,
          date: date,
          number: number,
          truckId: truckId,
          truckOwnerId: truckOwnerId,
          address: address,
          userId: _userId);
      await _read(appointmentRepositoryProvider).create(id: id, item: item);
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
}
