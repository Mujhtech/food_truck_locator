import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/appointment_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseAppointmentRepository {
  Future<List<AppointMentModel>> get({required String userId});
  Future<void> create({required String id, required AppointMentModel item});
  Future<void> remove({required String userId, required String id});
  Future<void> update(
      {required String userId,
      required String id,
      required AppointMentModel item});
}

final appointmentRepositoryProvider =
    Provider<AppointmentRepository>((ref) => AppointmentRepository(ref.read));

class AppointmentRepository implements BaseAppointmentRepository {
  final Reader _read;
  const AppointmentRepository(this._read);

  @override
  Future<void> create(
      {required String id, required AppointMentModel item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .appointment()
          .doc(id)
          .set(item.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<AppointMentModel>> get({required String userId}) async {
    try {
      List<AppointMentModel> datas = [];
      final snap = await _read(firebaseFirestoreProvider)
          .appointment()
          .where('user_id', isEqualTo: userId)
          .get();
      for (var doc in snap.docs) {
        AppointMentModel data =
            AppointMentModel.fromJson(doc.data()! as Map<String, dynamic>);
        datas.add(data);
      }
      return datas;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> remove({required String userId, required String id}) async {
    try {
      await _read(firebaseFirestoreProvider).appointment().doc(id).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> update(
      {required String userId,
      required String id,
      required AppointMentModel item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .appointment()
          .doc(id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
