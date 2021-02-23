import 'package:localstorage/localstorage.dart';

import '../../../application/storage/local_storage.dart';
import '../../../infra/storage/local_storage_adater.dart';

CacheLocalStorage makeLocalStorage() =>
    LocalStorageAdapter(localStorage: LocalStorage('app_local'));
