import '../../../application/usecases/local_save_current_account.dart';
import '../../../domain/usecases/save_current_account.dart';
import '../storage/cache_local_storage_factory.dart';

class SaveCurrentAccountFactory {
  static SaveCurrentAccount makeLocalSaveCurrentAccount() =>
      LocalSaveCurrentAccount(
        localStorage: makeLocalStorage(),
      );
}
