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
