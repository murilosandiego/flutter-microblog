import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_cubit.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_state.dart';
import 'package:boticario_news/ui/pages/login/login_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FormLoginCubitSpy extends MockBloc<FormLoginState>
    implements FormLoginCubit {}

main() {
  FormLoginCubitSpy formLoginCubit;

  setUp(() {
    formLoginCubit = FormLoginCubitSpy();
  });

  testWidgets('Should call handles with correct values', (tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    await _loadPage(tester, formLoginCubit);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);
    verify(formLoginCubit.handleEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(formLoginCubit.handlePassword(password));
  });

  testWidgets('Should show error message if email is invalid', (tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    whenListen<FormLoginState>(
      formLoginCubit,
      Stream.fromIterable(
        [FormLoginState(email: Email.pure('invalid'))],
      ),
    );
    await _loadPage(tester, formLoginCubit);
    await tester.pump();

    expect(find.text('E-mail inválido'), findsOneWidget);
  });

  testWidgets('Should show error message if email is empty', (tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    whenListen<FormLoginState>(
      formLoginCubit,
      Stream.fromIterable(
        [FormLoginState(email: Email.pure(''))],
      ),
    );
    await _loadPage(tester, formLoginCubit);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should show error if password is invalid', (tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    whenListen<FormLoginState>(
      formLoginCubit,
      Stream.fromIterable(
        [FormLoginState(password: Password.pure('123'))],
      ),
    );
    await _loadPage(tester, formLoginCubit);
    await tester.pump();

    expect(find.text('Senha muito curta'), findsOneWidget);
  });

  testWidgets('Should show error if password is empty', (tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    whenListen<FormLoginState>(
      formLoginCubit,
      Stream.fromIterable(
        [FormLoginState(password: Password.pure(''))],
      ),
    );
    await _loadPage(tester, formLoginCubit);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });
}

Future _loadPage(WidgetTester tester, FormLoginCubitSpy formLoginCubit) async {
  await tester.pumpWidget(
    MaterialApp(
        home: BlocProvider<FormLoginCubit>.value(
      value: formLoginCubit,
      child: LoginPage(),
    )),
  );
}
