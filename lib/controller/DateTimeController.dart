import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier {
  DateTime? d;
  TimeOfDay? t;

  dateChanged({required DateTime dateTime}) {
    d = dateTime;
    notifyListeners();
  }

  clearDateTime() {
    t = null;
    d = null;
    notifyListeners();
  }

  timeChanged({required TimeOfDay time}) {
    t = time;
    notifyListeners();
  }
}
