import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  SharedPreferences _preferences;

  static final LocalStorage _instance = LocalStorage._();

  static LocalStorage get instance => _instance;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get preferences => _preferences;
}
