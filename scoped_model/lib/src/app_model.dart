import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  static const platform =
      const MethodChannel('com.example.scoped_model/battery');

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

  String _battery = 'Unknown battery level';
  String get batteryLevel => _battery;

  void setBatteryLevel(String level) {
    _battery = level;
    notifyListeners();
  }

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = ' $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setBatteryLevel(batteryLevel);
  }
}
