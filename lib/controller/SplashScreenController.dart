import 'package:flutter/cupertino.dart';

class SplashScreenController extends ChangeNotifier {
  bool _isSplash = true;

  get getSplash {
    return _isSplash;
  }

  changeSplash() {
    _isSplash = false;
    notifyListeners();
  }
}
