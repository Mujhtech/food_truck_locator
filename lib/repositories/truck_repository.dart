import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/truck_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseTruckRepository {
  Future<List<TruckModel>> get({required String userId});
  Future<void> create({required String id, required TruckModel item});
  Future<void> remove({required String id});
  Future<void> update({required String id, required TruckModel item});
}

final truckRepositoryProvider =
    Provider<TruckRepository>((ref) => TruckRepository(ref.read));

class TruckRepository implements BaseTruckRepository {
  final Reader _read;
  const TruckRepository(this._read);

  @override
  Future<void> create({required String id, required TruckModel item}) async {
    try {
      await _read(firebaseFirestoreProvider).truck().doc(id).set(item.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<TruckModel>> get({required String userId}) async {
    try {
      List<TruckModel> trucks = [];
      final snap = await _read(firebaseFirestoreProvider)
          .truck()
          .where('user_id', isEqualTo: userId)
          .get();
      for (var doc in snap.docs) {
        TruckModel truck =
            TruckModel.fromJson(doc.data()! as Map<String, dynamic>);
        trucks.add(truck);
      }
      return trucks;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> remove({required String id}) async {
    try {
      await _read(firebaseFirestoreProvider).truck().doc(id).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> update({required String id, required TruckModel item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .truck()
          .doc(id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
