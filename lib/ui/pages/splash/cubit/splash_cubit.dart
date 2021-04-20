import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:boticario_news/ui/helpers/user_manager.dart';
import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../domain/usecases/load_current_account.dart';
import 'splash_state.dart';

class SplashCubit extends StateNotifier<SplashState> {
  final LoadCurrentAccount loadCurrentAccount;
  final UserManager userManager;

  SplashCubit({
    @required this.loadCurrentAccount,
    @required this.userManager,
  }) : super(SplashInitial());

  Future<void> checkAccount({bool test = false}) async {
    try {
      await _handleCurrentUser();
    } catch (_) {
      state = SplashToWelcome();
    }
  }

  Future<void> _handleCurrentUser() async {
    final account = await _getCurrentAccount();

    if (!_hasUser(account)) {
      state = SplashToWelcome();
      return;
    }

    _setCurrentUser(account);
    state = SplashToHome();
  }

  Future<AccountEntity> _getCurrentAccount() async {
    final account = await loadCurrentAccount.load();
    return account;
  }

  bool _hasUser(AccountEntity account) => account != null;

  void _setCurrentUser(AccountEntity account) {
    userManager.addUser(account);
  }
}
