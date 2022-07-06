import 'package:flutter/material.dart';

class ThemesProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode {
    return _themeMode;
  }

  bool get isDarkMode {
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme(bool isOn) {
    if (isOn == true) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
