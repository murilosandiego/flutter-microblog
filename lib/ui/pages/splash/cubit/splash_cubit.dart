import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/load_current_account.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LoadCurrentAccount loadCurrentAccount;

  SplashCubit({
    @required this.loadCurrentAccount,
  }) : super(SplashInitial());

  Future<void> checkAccount({bool test = false}) async {
    try {
      if (!test) {
        await Future.delayed(Duration(seconds: 3));
      }

      final account = await loadCurrentAccount.load();

      print(account);
      if (account?.token != null) {
        // userSession.saveUser(
        //   name: account.username,
        //   id: account.id,
        // );
        emit(SplashToHome());
      } else {
        emit(SplashToWelcome());
      }
    } catch (_) {
      print('Algum erro ocorreu');
    }
  }
}
