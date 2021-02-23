import '../../../application/usecases/local_load_current_account.dart';
import '../../../domain/usecases/load_current_account.dart';
import '../storage/cache_local_storage_factory.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() => LocalLoadCurrentAccount(
      localStorage: makeLocalStorage(),
    );
