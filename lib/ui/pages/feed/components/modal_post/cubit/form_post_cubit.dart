import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../../helpers/form_validators.dart';

part 'form_post_state.dart';

class FormPostCubit extends StateNotifier<FormPostState> {
  FormPostCubit() : super(FormPostState());

  handleMessage(String text) {
    final message = MessageInput.dirty(text);

    state = state.copyWith(
      message: message.valid ? message : MessageInput.pure(text),
      status: Formz.validate([message]),
    );
  }
}
