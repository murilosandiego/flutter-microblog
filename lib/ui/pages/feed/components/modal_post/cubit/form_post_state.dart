part of 'form_post_cubit.dart';

class FormPostState extends Equatable {
  final MessageInput message;
  final FormzStatus status;
  final String errorMessage;

  FormPostState({
    this.message = const MessageInput.pure(null),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  FormPostState copyWith({
    MessageInput message,
    FormzStatus status,
    String errorMessage,
  }) {
    return FormPostState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [message, status, errorMessage];

  @override
  bool get stringify => true;
}
