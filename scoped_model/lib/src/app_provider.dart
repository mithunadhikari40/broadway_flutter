
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider with ChangeNotifier {
  int _counter = 0;
  int get count => _counter;
  void incrementCount() {
    _counter++;
    notifyListeners();
  }

  bool _isDark = false;
  ThemeData get getTheme {
    if (_isDark) {
      return ThemeData.dark();
    }
    return ThemeData.light();
  }

  void changeTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
