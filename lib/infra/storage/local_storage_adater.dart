import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart' show required;

import '../../application/storage/local_storage.dart';

class LocalStorageAdapter implements CacheLocalStorage {
  final SharedPreferences localStorage;

  LocalStorageAdapter({@required this.localStorage});

  @override
  Future<void> save({@required key, @required value}) async {
    await localStorage.setString(key, value);
  }

  @override
  Future fetch({@required String key}) async {
    final data = localStorage.getString(key);
    return data;
  }

  @override
  Future<void> clear() async {
    await localStorage.clear();
  }
}
