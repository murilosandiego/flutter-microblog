part of 'form_signup_cubit.dart';

class FormSignUpState extends Equatable {
  final NameInput name;
  final Email email;
  final Password password;
  final FormzStatus status;

  FormSignUpState({
    this.name = const NameInput.pure(null),
    this.email = const Email.pure(null),
    this.password = const Password.pure(null),
    this.status = FormzStatus.pure,
  });

  FormSignUpState copyWith({
    Email email,
    Password password,
    FormzStatus status,
    NameInput name,
  }) {
    return FormSignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        name: name ?? this.name);
  }

  @override
  List<Object> get props => [email, password, status, name];

  @override
  bool get stringify => true;
}
