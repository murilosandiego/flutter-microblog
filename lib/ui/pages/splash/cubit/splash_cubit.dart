import 'package:bloc/bloc.dart';
import 'package:boticario_news/ui/helpers/user_manager.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/load_current_account.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LoadCurrentAccount loadCurrentAccount;
  final UserManager userManager;

  SplashCubit({
    @required this.loadCurrentAccount,
    @required this.userManager,
  }) : super(SplashInitial());

  Future<void> checkAccount({bool test = false}) async {
    try {
      final account = await loadCurrentAccount.load();

      if (account != null) {
        userManager.addUser(account);
        emit(SplashToHome());
      } else {
        emit(SplashToWelcome());
      }
    } catch (_) {
      emit(SplashToWelcome());
    }
  }
}
