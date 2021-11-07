import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference user() => collection('users');
  CollectionReference transaction() => collection('transactions');
}
