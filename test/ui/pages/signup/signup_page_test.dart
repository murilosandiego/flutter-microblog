import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_cubit.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_state.dart';
import 'package:boticario_news/ui/pages/signup/signup_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FormSignUpCubitSpy extends MockBloc<FormSignUpState>
    implements FormSignUpCubit {}

main() {
  FormSignUpCubitSpy formSignCubit;

  setUp(() {
    formSignCubit = FormSignUpCubitSpy();
  });

  testWidgets('Should call handles with correct values', (tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    await _loadPage(tester, formSignCubit);

    final name = faker.person.firstName();
    await tester.enterText(find.bySemanticsLabel('Nome'), name);
    verify(formSignCubit.handleName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);
    verify(formSignCubit.handleEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(formSignCubit.handlePassword(password));
  });

  testWidgets('Should show error message if name is invalid', (tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    whenListen<FormSignUpState>(
      formSignCubit,
      Stream.fromIterable(
        [FormSignUpState(name: NameInput.pure('us'))],
      ),
    );
    await _loadPage(tester, formSignCubit);
    await tester.pump();

    expect(find.text('Nome muito curto'), findsOneWidget);
  });

  testWidgets('Should show error message if name is empty', (tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    whenListen<FormSignUpState>(
      formSignCubit,
      Stream.fromIterable(
        [FormSignUpState(name: NameInput.pure(''))],
      ),
    );
    await _loadPage(tester, formSignCubit);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should show error message if email is invalid', (tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    whenListen<FormSignUpState>(
      formSignCubit,
      Stream.fromIterable(
        [FormSignUpState(email: Email.pure('invalid'))],
      ),
    );
    await _loadPage(tester, formSignCubit);
    await tester.pump();

    expect(find.text('E-mail inválido'), findsOneWidget);
  });

  testWidgets('Should show error message if email is empty', (tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    whenListen<FormSignUpState>(
      formSignCubit,
      Stream.fromIterable(
        [FormSignUpState(email: Email.pure(''))],
      ),
    );
    await _loadPage(tester, formSignCubit);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should show error if password is invalid', (tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    whenListen<FormSignUpState>(
      formSignCubit,
      Stream.fromIterable(
        [FormSignUpState(password: Password.pure('123'))],
      ),
    );
    await _loadPage(tester, formSignCubit);
    await tester.pump();

    expect(find.text('Senha muito curta'), findsOneWidget);
  });

  testWidgets('Should show error if password is empty', (tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    whenListen<FormSignUpState>(
      formSignCubit,
      Stream.fromIterable(
        [FormSignUpState(password: Password.pure(''))],
      ),
    );
    await _loadPage(tester, formSignCubit);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });
}

Future _loadPage(WidgetTester tester, FormSignUpCubitSpy formSignCubit) async {
  await tester.pumpWidget(
    MaterialApp(
        home: BlocProvider<FormSignUpCubit>.value(
      value: formSignCubit,
      child: SignUpPage(),
    )),
  );
}
