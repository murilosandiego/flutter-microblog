import 'package:bloc/bloc.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:boticario_news/ui/helpers/user_manager.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../../../domain/errors/domain_error.dart';
import '../../../../domain/usecases/authentication.dart';
import '../../../../domain/usecases/save_current_account.dart';
import '../../../helpers/form_validators.dart';
import 'form_state.dart';

class FormLoginCubit extends Cubit<FormLoginState> {
  final Authetication authetication;
  final SaveCurrentAccount saveCurrentAccount;
  final UserManager userManager;

  FormLoginCubit({
    @required this.authetication,
    @required this.saveCurrentAccount,
    @required this.userManager,
  }) : super(FormLoginState());

  Future<void> auth() async {
    try {
      if (!_isFormValid) return;

      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      final account = await authetication.auth(AuthenticationParams(
        email: state.email.value,
        secret: state.password.value,
      ));

      await saveCurrentAccount.save(account);

      userManager.addUser(account);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on DomainError catch (error) {
      String errorMessage = UIError.unexpected.description;
      if (error == DomainError.invalidCredentials) {
        errorMessage = UIError.invalidCredentials.description;
      }

      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: errorMessage,
      ));

      emit(state.copyWith(status: FormzStatus.valid, errorMessage: ''));
    }
  }

  void handleEmail(String text) {
    final email = Email.dirty(text);

    emit(state.copyWith(
      email: email.valid ? email : Email.pure(text),
      status: Formz.validate([email, state.password]),
    ));
  }

  void handlePassword(String text) {
    final password = Password.dirty(text);

    emit(state.copyWith(
      password: password.valid ? password : Password.pure(text),
      status: Formz.validate([state.email, password]),
    ));
  }

  bool get _isFormValid {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      email: email,
      password: password,
      status: Formz.validate([email, password]),
    ));

    return state.status.isValidated;
  }
}
