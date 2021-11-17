import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/user_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseUserRepository {
  Future<List<UserModel>> get();
}

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref.read));

class UserRepository implements BaseUserRepository {
  final Reader _read;
  const UserRepository(this._read);

  @override
  Future<List<UserModel>> get() async {
    try {
      List<UserModel> datas = [];
      final snap = await _read(firebaseFirestoreProvider).user().get();
      for (var doc in snap.docs) {
        UserModel data =
            UserModel.fromJson(doc.data()! as Map<String, dynamic>);
        datas.add(data);
      }
      return datas;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
