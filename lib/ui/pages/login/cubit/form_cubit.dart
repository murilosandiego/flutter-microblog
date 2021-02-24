import 'package:bloc/bloc.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../../../domain/errors/domain_error.dart';
import '../../../../domain/usecases/authentication.dart';
import '../../../../domain/usecases/save_current_account.dart';
import '../../../helpers/form_validators.dart';

part 'form_state.dart';

class FormLoginCubit extends Cubit<FormLoginState> {
  final Authetication authetication;
  final SaveCurrentAccount saveCurrentAccount;
  FormLoginCubit({
    @required this.authetication,
    @required this.saveCurrentAccount,
  }) : super(FormLoginState());

  Future<void> auth() async {
    try {
      if (!isFormValid) return;

      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final account = await authetication.auth(AuthenticationParams(
          email: state.email.value, secret: state.password.value));

      await saveCurrentAccount.save(account);

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
      emit(state.copyWith(status: FormzStatus.valid));
    }
  }

  void handleEmail(text) {
    final email = Email.dirty(text);

    emit(state.copyWith(
      email: email.valid ? email : Email.pure(text),
      status: Formz.validate([email, state.password]),
    ));
  }

  void handlePassword(text) {
    final password = Password.dirty(text);

    emit(state.copyWith(
      password: password.valid ? password : Password.pure(text),
      status: Formz.validate([state.email, password]),
    ));
  }

  String get emailError {
    if (state.email.error == EmailValidationError.isNull) return null;
    if (state.email.error == EmailValidationError.invalid)
      return 'E-mail inválido';
    return state.email.error == EmailValidationError.empty
        ? 'Campo obrigatório'
        : null;
  }

  String get passwordError {
    if (state.password.error == PasswordValidationError.isNull) return null;
    if (state.password.error == PasswordValidationError.invalid)
      return 'Senha muito curta';
    return state.password.error == PasswordValidationError.empty
        ? 'Campo obrigatório'
        : null;
  }

  bool get isFormValid {
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
