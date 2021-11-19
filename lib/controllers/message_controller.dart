import 'package:flutter/material.dart';
import 'package:food_truck_locator/controllers/user_controller.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:food_truck_locator/models/message_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/repositories/message_repository.dart';
import 'package:food_truck_locator/services/backend_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messageControllerProvider =
    ChangeNotifierProvider<MessageController>((ref) {
  return MessageController(ref.read)..retrieve();
});

class MessageController extends ChangeNotifier {
  final Reader _read;
  String? error;
  List<MessageModel>? _messages;
  bool loading = false;
  BackendServices backendServices = BackendServices();

  List<MessageModel>? get messages => _messages;

  MessageController(this._read) {
    retrieve();
  }

  Future<void> retrieve() async {
    try {
      loading = true;
      notifyListeners();
      final items = await _read(messageRepositoryProvider).get();
      _messages = items;
      loading = false;
      notifyListeners();
    } on CustomException catch (e) {
      error = e.message;
      loading = false;
      notifyListeners();
    }
  }

  List<MessageModel> filterMessageByOrderId(String id) {
    List<MessageModel> filters = [];
    if (_messages != null && _messages!.isNotEmpty) {
      for (final data in _messages!) {
        if (data.orderId == id) {
          filters.add(data);
        }
      }
    }
    return filters;
  }

  Future<bool> create(
      String orderId, String foodOwnerId, String userId, String message) async {
    try {
      loading = true;
      notifyListeners();
      String id = _read(firebaseFirestoreProvider).order().doc().id.toString();
      MessageModel item = MessageModel(
          id: id,
          message: message,
          orderId: orderId,
          foodOwnerId: foodOwnerId,
          userId: userId,
          createdAt: DateTime.now());
      final user = _read(userControllerProvider).filterUserbyId(userId);
      final owner = _read(userControllerProvider).filterUserbyId(foodOwnerId);
      // await backendServices.sendNotification(
      //     user.fcmToken!, 'Order', 'You just order ${data.item!.title!}');
      await backendServices.sendNotification(
          owner.fcmToken!, 'Order', 'New message from ${user.fullName}');
      await _read(messageRepositoryProvider).create(id: id, item: item);
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
}
