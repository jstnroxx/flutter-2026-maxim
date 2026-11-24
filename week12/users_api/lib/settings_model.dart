import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends ChangeNotifier {
  final SharedPreferencesAsync _prefs;
  bool _dark;
  String? _city;

  SettingsModel(this._prefs, {required this._dark, required this._city});

  bool get dark => _dark;
  String? get city => _city;

  Future<void> setDark(bool val) async {
    _dark = val;
    notifyListeners();

    await _prefs.setBool('darkMode', val);
  }

  Future<void> setCity(String? val) async {
    _city = val;
    notifyListeners();

    if (val != null) {
      await _prefs.setString('cityFilter', val);
    } else {
      await _prefs.remove('cityFilter');
    }
  }
}