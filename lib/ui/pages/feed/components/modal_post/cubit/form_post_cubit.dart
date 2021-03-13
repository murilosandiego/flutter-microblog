import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../../helpers/form_validators.dart';

part 'form_post_state.dart';

class FormPostCubit extends Cubit<FormPostState> {
  FormPostCubit() : super(FormPostState());

  handleMessage(String text) {
    final message = MessageInput.dirty(text);

    emit(state.copyWith(
      message: message.valid ? message : MessageInput.pure(text),
      status: Formz.validate([message]),
    ));
  }
}
