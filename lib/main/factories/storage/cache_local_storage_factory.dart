import 'package:boticario_news/main/singletons/local_storage_singleton.dart';

import '../../../application/storage/local_storage.dart';
import '../../../infra/storage/local_storage_adater.dart';

CacheLocalStorage makeLocalStorage() => LocalStorageAdapter(
      localStorage: LocalStorage.instance.preferences,
    );
