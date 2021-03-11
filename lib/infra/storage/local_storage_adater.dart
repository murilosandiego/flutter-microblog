import 'package:localstorage/localstorage.dart' as LocalStorageLib;
import 'package:meta/meta.dart' show required;

import '../../application/storage/local_storage.dart';

class LocalStorageAdapter implements CacheLocalStorage {
  final LocalStorageLib.LocalStorage localStorage;

  LocalStorageAdapter({@required this.localStorage});

  @override
  Future<void> save({@required key, @required value}) async {
    await localStorage.setItem(key, value);
  }

  @override
  Future fetch({@required String key}) async {
    final data = await localStorage.getItem(key);
    return data;
  }

  @override
  Future<void> clear() async {
    await localStorage.clear();
  }
}
