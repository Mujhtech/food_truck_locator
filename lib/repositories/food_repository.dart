import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/food_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseFoodRepository {
  Future<List<FoodModel>> get();
  Future<void> create({required String id, required FoodModel item});
  Future<void> remove({required String id});
  Future<void> update({required String id, required FoodModel item});
}

final foodRepositoryProvider =
    Provider<FoodRepository>((ref) => FoodRepository(ref.read));

class FoodRepository implements BaseFoodRepository {
  final Reader _read;
  const FoodRepository(this._read);

  @override
  Future<void> create({required String id, required FoodModel item}) async {
    try {
      await _read(firebaseFirestoreProvider).food().doc(id).set(item.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<FoodModel>> get() async {
    try {
      List<FoodModel> foods = [];
      final snap = await _read(firebaseFirestoreProvider)
          .food()
          .get();
      for (var doc in snap.docs) {
        FoodModel food =
            FoodModel.fromJson(doc.data()! as Map<String, dynamic>);
        foods.add(food);
      }
      return foods;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> remove({required String id}) async {
    try {
      await _read(firebaseFirestoreProvider).food().doc(id).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> update({required String id, required FoodModel item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .food()
          .doc(id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
