import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:boticario_news/domain/usecases/add_account.dart';
import 'package:boticario_news/domain/usecases/save_current_account.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_cubit.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_state.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/mockito.dart';

class AddAccountSpy extends Mock implements AddAccount {}

class SaveCurrentAccountSpy extends Mock implements SaveCurrentAccount {}

main() {
  FormSignUpCubit sut;
  AddAccountSpy addAccount;
  SaveCurrentAccountSpy saveCurrentAccount;

  final String validUsername = faker.person.firstName();
  final String validEmail = faker.internet.email();
  final String validPassword = faker.internet.password();
  final String token = faker.guid.guid();

  final String invalidUsername = 'us';
  final String invalidEmail = 'invalid_email';
  final String invalidPassword = '12345';

  final successFlowSubmitForm = [
    FormSignUpState(
      name: NameInput.dirty(validUsername),
      status: FormzStatus.invalid,
    ),
    FormSignUpState(
      name: NameInput.dirty(validUsername),
      email: Email.dirty(validEmail),
      status: FormzStatus.invalid,
    ),
    FormSignUpState(
      name: NameInput.dirty(validUsername),
      email: Email.dirty(validEmail),
      password: Password.dirty(validPassword),
      status: FormzStatus.valid,
    ),
    FormSignUpState(
      name: NameInput.dirty(validUsername),
      email: Email.dirty(validEmail),
      password: Password.dirty(validPassword),
      status: FormzStatus.submissionInProgress,
    ),
  ];

  setUp(() {
    addAccount = AddAccountSpy();
    saveCurrentAccount = SaveCurrentAccountSpy();

    sut = FormSignUpCubit(
      addAccount: addAccount,
      saveCurrentAccount: saveCurrentAccount,
    );
  });

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits FormSignUpState with NameInput.dirty if name is valid',
    build: () => sut,
    act: (cubit) => cubit.handleName(validUsername),
    expect: [
      FormSignUpState(
        name: NameInput.dirty(validUsername),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits FormSignUpState with NameInput.pure if name is invalid',
    build: () => sut,
    act: (cubit) => cubit.handleName(invalidUsername),
    expect: [
      FormSignUpState(
        name: NameInput.pure(invalidUsername),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits FormSignUpState with Email.dirty if email is valid',
    build: () => sut,
    act: (cubit) => cubit.handleEmail(validEmail),
    expect: [
      FormSignUpState(
        email: Email.dirty(validEmail),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits FormSignUpState with Email.pure if email is invalid',
    build: () => sut,
    act: (cubit) => cubit.handleEmail(invalidEmail),
    expect: [
      FormSignUpState(
        email: Email.pure(invalidEmail),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits FormSignUpState with Password.dirty if password is valid',
    build: () => sut,
    act: (cubit) => cubit.handlePassword(validPassword),
    expect: [
      FormSignUpState(
        password: Password.dirty(validPassword),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits FormSignUpState with Password.pure if password is invalid',
    build: () => sut,
    act: (cubit) => cubit.handlePassword(invalidPassword),
    expect: [
      FormSignUpState(
        password: Password.pure(invalidPassword),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should call AddAccount with correct values',
    build: () => sut,
    act: (cubit) {
      cubit.handleName(validUsername);
      cubit.handlePassword(validPassword);
      cubit.handleEmail(validEmail);
      cubit.add();
    },
    verify: (_) {
      verify(addAccount.add(AddAccountParams(
        email: validEmail,
        secret: validPassword,
        name: validUsername,
      ))).called(1);
    },
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should call SaveCurrentAccount with correct values',
    build: () {
      when(addAccount.add(any)).thenAnswer(
        (_) async =>
            AccountEntity(token: token, id: 1, username: validUsername),
      );
      return sut;
    },
    act: (cubit) async {
      cubit.handleName(validUsername);
      cubit.handlePassword(validPassword);
      cubit.handleEmail(validEmail);
      await cubit.add();
    },
    verify: (_) {
      verify(saveCurrentAccount.save(AccountEntity(
        token: token,
        id: 1,
        username: validUsername,
      ))).called(1);
    },
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should not call AddAccount and SaveCurrentAccount if is form invalid',
    build: () => sut,
    act: (cubit) {
      cubit.handleName(invalidUsername);
      cubit.handleEmail(validEmail);
      cubit.handlePassword(validPassword);
      cubit.add();
    },
    verify: (_) {
      verifyNever(addAccount.add(AddAccountParams(
        name: invalidUsername,
        email: validEmail,
        secret: validPassword,
      )));
    },
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits correct events on InvalidCredentialsError',
    build: () {
      when(addAccount.add(any)).thenThrow(DomainError.invalidCredentials);
      return sut;
    },
    act: (cubit) async {
      cubit.handleName(validUsername);
      cubit.handleEmail(validEmail);
      cubit.handlePassword(validPassword);
      await cubit.add();
    },
    expect: [
      ...successFlowSubmitForm,
      FormSignUpState(
        name: NameInput.dirty(validUsername),
        email: Email.dirty(validEmail),
        password: Password.dirty(validPassword),
        status: FormzStatus.submissionFailure,
        errorMessage: UIError.emailInUse.description,
      ),
      FormSignUpState(
        name: NameInput.dirty(validUsername),
        email: Email.dirty(validEmail),
        password: Password.dirty(validPassword),
        status: FormzStatus.valid,
        errorMessage: '',
      )
    ],
  );

  blocTest<FormSignUpCubit, FormSignUpState>(
    'Should emits correct events on Unexpected',
    build: () {
      when(addAccount.add(any)).thenThrow(DomainError.unexpected);
      return sut;
    },
    act: (cubit) async {
      cubit.handleName(validUsername);
      cubit.handleEmail(validEmail);
      cubit.handlePassword(validPassword);
      await cubit.add();
    },
    expect: [
      ...successFlowSubmitForm,
      FormSignUpState(
        name: NameInput.dirty(validUsername),
        email: Email.dirty(validEmail),
        password: Password.dirty(validPassword),
        status: FormzStatus.submissionFailure,
        errorMessage: UIError.unexpected.description,
      ),
      FormSignUpState(
        name: NameInput.dirty(validUsername),
        email: Email.dirty(validEmail),
        password: Password.dirty(validPassword),
        status: FormzStatus.valid,
        errorMessage: '',
      )
    ],
  );
}
