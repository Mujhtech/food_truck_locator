import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/order_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseOrderRepository {
  Future<List<OrderModel>> getAll();
  Future<void> create({required String id, required OrderModel item});
  Future<void> remove({required String userId, required String id});
  Future<void> update({required String id, required OrderModel item});
}

final orderRepositoryProvider =
    Provider<OrderRepository>((ref) => OrderRepository(ref.read));

class OrderRepository implements BaseOrderRepository {
  final Reader _read;
  const OrderRepository(this._read);

  @override
  Future<void> create({required String id, required OrderModel item}) async {
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
  Future<List<OrderModel>> getAll() async {
    try {
      List<OrderModel> datas = [];
      final snap = await _read(firebaseFirestoreProvider).order().get();
      for (var doc in snap.docs) {
        OrderModel data =
            OrderModel.fromJson(doc.data()! as Map<String, dynamic>);
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
  Future<void> update({required String id, required OrderModel item}) async {
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
