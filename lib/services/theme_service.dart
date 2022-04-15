import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  ThemeService(this.sharedPreferences);
  bool _darkTheme = true;

  static const darkThemKey = "dark_theme";

  bool get darkTheme {
    return sharedPreferences.getBool(darkThemKey) ?? _darkTheme;
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreferences.setBool(
        darkThemKey, value); // using defined key, and the value coming in
    notifyListeners();
  }
}

// class BudgetService extends ChangeNotifier {
//   double _budget = 2000.0;

//   double get budget => _budget;

//   set budget(double value) {
//     _budget = value;
//     notifyListeners();
//   }
// }
