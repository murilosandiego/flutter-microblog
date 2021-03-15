import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:boticario_news/ui/pages/feed/components/modal_post/cubit/form_post_cubit.dart';
import 'package:faker/faker.dart';
import 'package:formz/formz.dart';
import 'package:test/test.dart';

main() {
  FormPostCubit sut;
  final String invalidMessage = faker.randomGenerator.string(300, min: 281);
  final String validMessage = faker.randomGenerator.string(280, min: 280);

  setUp(() {
    sut = FormPostCubit();
  });

  blocTest<FormPostCubit, FormPostState>(
    'Should emits FormLoginState with MessageInput.pure if message is invalid',
    build: () => sut,
    act: (cubit) => cubit.handleMessage(invalidMessage),
    expect: [
      FormPostState(
        message: MessageInput.pure(invalidMessage),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormPostCubit, FormPostState>(
    'Should emits FormLoginState with MessageInput.pure if message is empty',
    build: () => sut,
    act: (cubit) => cubit.handleMessage(''),
    expect: [
      FormPostState(
        message: MessageInput.pure(''),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormPostCubit, FormPostState>(
    'Should emits FormLoginState with MessageInput.dirty if message is valid',
    build: () => sut,
    act: (cubit) => cubit.handleMessage(validMessage),
    expect: [
      FormPostState(
        message: MessageInput.dirty(validMessage),
        status: FormzStatus.valid,
      ),
    ],
  );
}
