import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
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
