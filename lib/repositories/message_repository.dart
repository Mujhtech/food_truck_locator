import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/message_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseMessageRepository {
  Future<List<MessageModel>> get();
  Future<void> create({required String id, required MessageModel item});
}

final messageRepositoryProvider =
    Provider<MessageRepository>((ref) => MessageRepository(ref.read));

class MessageRepository implements BaseMessageRepository {
  final Reader _read;
  const MessageRepository(this._read);

  @override
  Future<void> create({required String id, required MessageModel item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .message()
          .doc(id)
          .set(item.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<MessageModel>> get() async {
    try {
      List<MessageModel> datas = [];
      final snap = await _read(firebaseFirestoreProvider)
          .message()
          .orderBy('created_at', descending: true)
          .get();
      for (var doc in snap.docs) {
        MessageModel data =
            MessageModel.fromJson(doc.data()! as Map<String, dynamic>);
        datas.add(data);
      }
      return datas;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
