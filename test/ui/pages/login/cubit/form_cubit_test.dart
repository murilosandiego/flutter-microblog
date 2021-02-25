import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:boticario_news/domain/usecases/authentication.dart';
import 'package:boticario_news/domain/usecases/save_current_account.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_cubit.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/mockito.dart';

class AuthenticationSpy extends Mock implements Authetication {}

class SaveAccountSpy extends Mock implements SaveCurrentAccount {}

main() {
  FormLoginCubit sut;
  AuthenticationSpy authetication;
  SaveAccountSpy saveCurrentAccount;

  setUp(() {
    authetication = AuthenticationSpy();
    saveCurrentAccount = SaveAccountSpy();

    sut = FormLoginCubit(
      authetication: authetication,
      saveCurrentAccount: saveCurrentAccount,
    );
  });

  blocTest<FormLoginCubit, FormLoginState>(
    'Should emits FormLoginState with Email.pure if email is invalid',
    build: () => sut,
    act: (cubit) => cubit.handleEmail('invalid_email'),
    expect: [
      FormLoginState(
        email: Email.pure('invalid_email'),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormLoginCubit, FormLoginState>(
    'Should emits FormLoginState with Email.dirty if email is valid',
    build: () => sut,
    act: (cubit) => cubit.handleEmail('mail@mail.com'),
    expect: [
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormLoginCubit, FormLoginState>(
    'Should emits FormLoginState with Password.pure if password is invalid',
    build: () => sut,
    act: (cubit) => cubit.handlePassword('123'),
    expect: [
      FormLoginState(
        password: Password.pure('123'),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormLoginCubit, FormLoginState>(
    'Should emits FormLoginState with Password.dirty if password is valid',
    build: () => sut,
    act: (cubit) => cubit.handlePassword('123456'),
    expect: [
      FormLoginState(
        password: Password.dirty('123456'),
        status: FormzStatus.invalid,
      ),
    ],
  );

  blocTest<FormLoginCubit, FormLoginState>(
    'Should call Authentication with correct values',
    build: () => sut,
    act: (cubit) {
      cubit.handlePassword('123456');
      cubit.handleEmail('mail@mail.com');
      cubit.auth();
    },
    verify: (_) {
      verify(authetication.auth(
              AuthenticationParams(email: 'mail@mail.com', secret: '123456')))
          .called(1);
    },
  );

  blocTest<FormLoginCubit, FormLoginState>(
    'Should call saveCurrentAccount with correct values',
    build: () {
      when(authetication.auth(any)).thenAnswer(
        (_) async => AccountEntity(token: 'token', id: 1, username: 'user'),
      );
      return sut;
    },
    act: (cubit) async {
      cubit.handlePassword('123456');
      cubit.handleEmail('mail@mail.com');
      await cubit.auth();
    },
    verify: (_) {
      verify(saveCurrentAccount
              .save(AccountEntity(token: 'token', id: 1, username: 'user')))
          .called(1);
    },
  );

  blocTest<FormLoginCubit, FormLoginState>(
    'Should emits correct events on InvalidCredentialsError',
    build: () {
      when(authetication.auth(any)).thenThrow(DomainError.invalidCredentials);
      return sut;
    },
    act: (cubit) async {
      cubit.handleEmail('mail@mail.com');
      cubit.handlePassword('123456');
      await cubit.auth();
    },
    expect: [
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        status: FormzStatus.invalid,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.valid,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.submissionInProgress,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.submissionFailure,
        errorMessage: UIError.invalidCredentials.description,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.valid,
        errorMessage: '',
      )
    ],
  );

  blocTest<FormLoginCubit, FormLoginState>(
    'Should emits correct events on Unexpected',
    build: () {
      when(authetication.auth(any)).thenThrow(DomainError.unexpected);
      return sut;
    },
    act: (cubit) async {
      cubit.handleEmail('mail@mail.com');
      cubit.handlePassword('123456');
      await cubit.auth();
    },
    expect: [
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        status: FormzStatus.invalid,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.valid,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.submissionInProgress,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.submissionFailure,
        errorMessage: UIError.unexpected.description,
      ),
      FormLoginState(
        email: Email.dirty('mail@mail.com'),
        password: Password.dirty('123456'),
        status: FormzStatus.valid,
        errorMessage: '',
      )
    ],
  );
}
