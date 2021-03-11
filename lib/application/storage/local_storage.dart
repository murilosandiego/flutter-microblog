import 'package:meta/meta.dart';

abstract class CacheLocalStorage {
  Future<void> save({@required String key, @required String value});
  Future fetch({@required String key});
  Future<void> clear();
}
