import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class themeController extends ChangeNotifier {
  bool _isDarkTheme = false;
  late SharedPreferences preferences;

  themeController({required this.preferences});

  get getTheme {
    _isDarkTheme = preferences.getBool('theme') ?? false;
    return _isDarkTheme;
  }

  changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    preferences.setBool('theme', _isDarkTheme);
    notifyListeners();
  }
}
