import 'package:bloc/bloc.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/add_account.dart';
import '../../../../domain/usecases/save_current_account.dart';

import 'form_signup_state.dart';

class FormSignUpCubit extends Cubit<FormSignUpState> {
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;
  FormSignUpCubit({
    @required this.addAccount,
    @required this.saveCurrentAccount,
  }) : super(FormSignUpState());

  Future<void> add() async {
    try {
      if (!_isFormValid) return;

      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      final account = await addAccount.add(
        AddAccountParams(
          name: state.name.value,
          email: state.email.value,
          secret: state.password.value,
        ),
      );

      await saveCurrentAccount.save(account);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on DomainError catch (error) {
      String errorMessage = UIError.unexpected.description;
      if (error == DomainError.invalidCredentials) {
        errorMessage = UIError.emailInUse.description;
      }

      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: errorMessage,
      ));
      emit(state.copyWith(status: FormzStatus.valid));
    }
  }

  void handleName(String text) {
    final name = NameInput.dirty(text);

    emit(state.copyWith(
      name: name.valid ? name : NameInput.pure(text),
      status: Formz.validate([name, state.email, state.password]),
    ));
  }

  void handleEmail(String text) {
    final email = Email.dirty(text);

    emit(state.copyWith(
      email: email.valid ? email : Email.pure(text),
      status: Formz.validate([email, state.name, state.password]),
    ));
  }

  void handlePassword(String text) {
    final password = Password.dirty(text);

    emit(state.copyWith(
      password: password.valid ? password : Password.pure(text),
      status: Formz.validate([password, state.name, state.email]),
    ));
  }

  String get nameError {
    if (state.name.error == NameValidationError.isNull) return null;
    if (state.name.error == NameValidationError.invalid)
      return 'Nome muito curto';
    return state.name.error == NameValidationError.empty
        ? 'Campo obrigatório'
        : null;
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

  bool get _isFormValid {
    final name = NameInput.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      name: name,
      email: email,
      password: password,
      status: Formz.validate([email, password, name]),
    ));

    return state.status.isValidated;
  }
}
