import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference user() => collection('users');
  CollectionReference truck() => collection('trucks');
  CollectionReference food() => collection('foods');
  CollectionReference order() => collection('orders');
  CollectionReference cart() => collection('carts');
  CollectionReference appointment() => collection('appointments');
}
