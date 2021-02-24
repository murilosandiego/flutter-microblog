import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../helpers/form_validators.dart';

class FormSignUpState extends Equatable {
  final NameInput name;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String errorMessage;

  FormSignUpState({
    this.name = const NameInput.pure(null),
    this.email = const Email.pure(null),
    this.password = const Password.pure(null),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  FormSignUpState copyWith(
      {Email email,
      Password password,
      FormzStatus status,
      NameInput name,
      String errorMessage}) {
    return FormSignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      name: name ?? this.name,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status, name, errorMessage];

  @override
  bool get stringify => true;
}
