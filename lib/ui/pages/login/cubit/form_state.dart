import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../helpers/form_validators.dart';

class FormLoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;
  final String errorMessage;

  FormLoginState({
    this.email = const Email.pure(null),
    this.password = const Password.pure(null),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  FormLoginState copyWith(
      {Email email,
      Password password,
      FormzStatus status,
      String errorMessage}) {
    return FormLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status, errorMessage];

  @override
  bool get stringify => true;
}
