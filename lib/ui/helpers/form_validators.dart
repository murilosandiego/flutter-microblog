import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty, isNull }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError validator(String value) {
    if (value == null) return EmailValidationError.isNull;
    if (value.isEmpty) return EmailValidationError.empty;
    return _emailRegex.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

extension EmailErrorMessageExtension on Email {
  String get errorMessage {
    if (this.error == EmailValidationError.isNull) return null;
    if (this.error == EmailValidationError.invalid) return 'E-mail inválido';
    return this.error == EmailValidationError.empty
        ? 'Campo obrigatório'
        : null;
  }
}

enum PasswordValidationError { invalid, empty, isNull }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    if (value == null) return PasswordValidationError.isNull;
    if (value.isEmpty) return PasswordValidationError.empty;
    return value.length >= 6 ? null : PasswordValidationError.invalid;
  }
}

extension PasswordErrorMessageExtension on Password {
  String get errorMessage {
    if (this.error == PasswordValidationError.isNull) return null;
    if (this.error == PasswordValidationError.invalid)
      return 'Senha muito curta';
    return this.error == PasswordValidationError.empty
        ? 'Campo obrigatório'
        : null;
  }
}

enum NameValidationError { invalid, empty, isNull }

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure([String value = '']) : super.pure(value);
  const NameInput.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError validator(String value) {
    if (value == null) return NameValidationError.isNull;
    if (value.isEmpty) return NameValidationError.empty;
    return value.length >= 3 ? null : NameValidationError.invalid;
  }
}

extension NameInputErrorMessageExtension on NameInput {
  String get errorMessage {
    if (this.error == NameValidationError.isNull) return null;
    if (this.error == NameValidationError.invalid) return 'Nome muito curto';
    return this.error == NameValidationError.empty ? 'Campo obrigatório' : null;
  }
}

enum MessageValidationError { invalid, empty, isNull }

class MessageInput extends FormzInput<String, MessageValidationError> {
  const MessageInput.pure([String value = '']) : super.pure(value);
  const MessageInput.dirty([String value = '']) : super.dirty(value);

  @override
  MessageValidationError validator(String value) {
    if (value == null) return MessageValidationError.isNull;
    if (value.isEmpty) return MessageValidationError.empty;
    return value.length <= 280 ? null : MessageValidationError.invalid;
  }
}

extension MessageInputErrorMessageExtension on MessageInput {
  String get errorMessage {
    if (this.error == MessageValidationError.isNull) return null;
    if (this.error == MessageValidationError.invalid)
      return 'Messagem muito longa';
    return this.error == MessageValidationError.empty
        ? 'Campo obrigatório'
        : null;
  }
}
