import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_truck_locator/models/user_model.dart';
import 'package:food_truck_locator/providers/firebase_provider.dart';
import 'package:food_truck_locator/repositories/auth_repository.dart';
import 'package:food_truck_locator/repositories/custom_exception.dart';
import 'package:food_truck_locator/extensions/firebase_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

final authControllerProvider = ChangeNotifierProvider<AuthController>(
    (ref) => AuthController(ref.read)..appStarted());

class AuthController extends ChangeNotifier {
  final Reader _read;
  User? _user;
  String? _error;
  UserModel? _fsUser;
  Status _status = Status.uninitialized;
  bool loading = false;

  String? get error => _error;
  Status? get status => _status;
  User? get fbUser => _user;
  UserModel? get user => _fsUser;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider)
        .authStateChanges
        .listen(_onAuthStateChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _authStateChangesSubscription?.cancel();
  }

  Future<void> appStarted() async {
    final user = _read(authRepositoryProvider).getCurrentUser();
    if (user == null) {
      return;
    }
  }

  Future<bool> socialSignIn(OAuthCredential credential) async {
    try {
      loading = true;
      notifyListeners();
      final res = await _read(authRepositoryProvider).socialSignIn(credential);
      final user = await _read(firebaseFirestoreProvider)
          .user()
          .doc(res!.user!.uid)
          .get();
      _fsUser = UserModel.fromDocument(user.data());
      _error = '';
      loading = false;
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      _error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> googleSignIn(OAuthCredential credential) async {
    try {
      loading = true;
      notifyListeners();
      final res = await _read(authRepositoryProvider).socialSignIn(credential);
      UserModel user = UserModel(
          //fcmToken: await _read(firebaseMessaging).getToken(),
          fcmToken: '',
          address: '',
          loginType: 'social',
          email: res!.user!.email,
          password: '',
          fullName: res.user!.displayName,
          phoneNumber: '',
          accountType: 'user',
          profileImage: res.user!.photoURL,
          lastLoggedIn: DateTime.now(),
          uid: res.user!.uid);
      await _read(firebaseFirestoreProvider)
          .user()
          .doc(user.uid)
          .set(user.toJson());
      _fsUser = user;
      _error = '';
      loading = false;
      return true;
    } on CustomException catch (e) {
      _error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> appleSignIn(OAuthCredential credential) async {
    try {
      loading = true;
      notifyListeners();
      final res = await _read(authRepositoryProvider).socialSignIn(credential);
      UserModel user = UserModel(
          //fcmToken: await _read(firebaseMessaging).getToken(),
          fcmToken: '',
          address: '',
          loginType: 'social',
          email: res!.user!.email,
          password: '',
          fullName: res.user!.displayName,
          phoneNumber: '',
          accountType: 'user',
          profileImage: res.user!.photoURL,
          lastLoggedIn: DateTime.now(),
          uid: res.user!.uid);
      await _read(firebaseFirestoreProvider)
          .user()
          .doc(user.uid)
          .set(user.toJson());
      _fsUser = user;
      _error = '';
      loading = false;
      return true;
    } on CustomException catch (e) {
      _error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      loading = true;
      notifyListeners();
      final res = await _read(authRepositoryProvider).signIn(email, password);
      final user = await _read(firebaseFirestoreProvider)
          .user()
          .doc(res!.user!.uid)
          .get();
      _fsUser = UserModel.fromDocument(user.data());
      _error = '';
      loading = false;
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      _error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String fullname,
      String phone, String accountType) async {
    try {
      loading = true;
      notifyListeners();
      final res = await _read(authRepositoryProvider).signUp(email, password);
      UserModel user = UserModel(
          fcmToken: await _read(firebaseMessaging).getToken(),
          address: '',
          loginType: 'email',
          email: email,
          password: password,
          fullName: fullname,
          phoneNumber: phone,
          accountType: accountType,
          profileImage: '',
          lastLoggedIn: DateTime.now(),
          uid: res!.user!.uid);
      await _read(firebaseFirestoreProvider)
          .user()
          .doc(user.uid)
          .set(user.toJson());
      _fsUser = user;
      _error = '';
      loading = false;
      notifyListeners();
      return true;
    } on CustomException catch (e) {
      _error = e.message;
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> uploadProfileImage(File file) async {
    try {
      loading = true;
      notifyListeners();
      if (_fsUser!.profileImage!.isNotEmpty) {
        Reference ref1 =
            _read(firebaseStorageProvider).refFromURL(_fsUser!.profileImage!);
        await ref1.delete();
      }
      Reference ref = _read(firebaseStorageProvider)
          .ref()
          .child("users/user_" + _user!.uid);
      UploadTask uploadTask = ref.putFile(file);
      final result = await uploadTask.then((res) async {
        return await res.ref.getDownloadURL();
      });
      await _read(firebaseFirestoreProvider)
          .user()
          .doc(_user!.uid)
          .update({'profile_picture': result});
      final user =
          await _read(firebaseFirestoreProvider).user().doc(_user!.uid).get();
      _fsUser = UserModel.fromDocument(user.data());
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeProfileImage() async {
    try {
      loading = true;
      notifyListeners();
      if (_fsUser!.profileImage!.isNotEmpty) {
        Reference ref1 =
            _read(firebaseStorageProvider).refFromURL(_fsUser!.profileImage!);
        await ref1.delete();
      }
      await _read(firebaseFirestoreProvider)
          .user()
          .doc(_user!.uid)
          .update({'profile_picture': ''});
      final user =
          await _read(firebaseFirestoreProvider).user().doc(_user!.uid).get();
      _fsUser = UserModel.fromDocument(user.data());
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateUser(
      String fullname, String email, String address, String number) async {
    try {
      loading = true;
      notifyListeners();
      await _read(firebaseFirestoreProvider).user().doc(_user!.uid).update({
        'full_name': fullname,
        'email': email,
        'contact_address': address,
        'phone_number': number
      });
      final user =
          await _read(firebaseFirestoreProvider).user().doc(_user!.uid).get();
      _fsUser = UserModel.fromDocument(user.data());
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePlan(String name, DateTime start, DateTime end) async {
    try {
      loading = true;
      notifyListeners();
      await _read(firebaseFirestoreProvider).user().doc(_user!.uid).update({
        'plan_name': name,
        'plan_start_date': start,
        'plan_expired_date': end,
      });
      final user =
          await _read(firebaseFirestoreProvider).user().doc(_user!.uid).get();
      _fsUser = UserModel.fromDocument(user.data());
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAccountType(String type) async {
    try {
      loading = true;
      notifyListeners();
      await _read(firebaseFirestoreProvider).user().doc(_user!.uid).update({
        'account_type': type,
      });
      final user =
          await _read(firebaseFirestoreProvider).user().doc(_user!.uid).get();
      _fsUser = UserModel.fromDocument(user.data());
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _read(authRepositoryProvider).signOut();
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _fsUser = null;
      _user = null;
      _status = Status.unauthenticated;
      notifyListeners();
    } else {
      _user = firebaseUser;
      final res =
          await _read(firebaseFirestoreProvider).user().doc(_user!.uid).get();
      _fsUser = UserModel.fromDocument(res.data());
      _status = Status.authenticated;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> deactivateAccount() async {
    try {
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> checkIfPhoneIsTaken(String username) async {
    try {
      loading = true;
      notifyListeners();
      var collectionRef = await _read(firebaseFirestoreProvider)
          .user()
          .where('phone_number', isEqualTo: username)
          .limit(1)
          .get();
      if (collectionRef.docs.isEmpty) {
        loading = false;
        notifyListeners();
        return true;
      } else {
        loading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      loading = true;
      notifyListeners();
      await _read(firebaseAuthProvider).sendPasswordResetEmail(email: email);
      loading = false;
      notifyListeners();
      return true;
    } catch (e) {
      loading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
