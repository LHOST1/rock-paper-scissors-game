import "package:flutter/material.dart";

ThemeData green = ThemeData(
  primarySwatch: Colors.green,
  scaffoldBackgroundColor: Colors.green.shade50,
);
ThemeData red = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.red.shade50,
);

class ThemeColorData with ChangeNotifier {
  String _name = '';
  String get name => _name;
  bool _isGreen = false;
  bool get isGreen => _isGreen;
  ThemeData get themeColor {
    return _isGreen ? green : red;
  }

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void toggleTheme() {
    _isGreen = !_isGreen;
    notifyListeners();
  }
}
