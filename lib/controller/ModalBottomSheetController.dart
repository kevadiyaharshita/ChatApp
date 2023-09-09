import 'package:flutter/material.dart';

class ModalSheetVisibility extends ChangeNotifier {
  bool _isVisible = false;

  get getVisibility {
    return _isVisible;
  }

  void changeVisibility({required bool v}) {
    _isVisible = v;
    notifyListeners();
  }
}
