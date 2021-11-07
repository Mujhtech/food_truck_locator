import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final textInputController = ChangeNotifierProvider<TextInputController>(
    (ref) => TextInputController(ref.read));

class TextInputController extends ChangeNotifier {
  TextEditingController depositAmount = TextEditingController();
  TextEditingController transferAmount = TextEditingController();
  final Reader _read;

  TextInputController(this._read);

  void setDepositAmount(String amount) {
    depositAmount.text = amount;
    notifyListeners();
  }

  void setTransferAmount(String amount) {
    transferAmount.text = amount;
    notifyListeners();
  }
}
