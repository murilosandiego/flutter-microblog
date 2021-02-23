part of 'form_cubit.dart';

class FormLoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  FormLoginState({
    this.email = const Email.pure(null),
    this.password = const Password.pure(null),
    this.status = FormzStatus.pure,
  });

  FormLoginState copyWith({
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return FormLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];

  @override
  bool get stringify => true;
}
