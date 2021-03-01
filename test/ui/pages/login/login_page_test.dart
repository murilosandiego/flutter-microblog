import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/main/routes/app_routes.dart';
import 'package:boticario_news/ui/helpers/form_validators.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_cubit.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_state.dart';
import 'package:boticario_news/ui/pages/feed/feed_page.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_cubit.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_state.dart';
import 'package:boticario_news/ui/pages/login/login_page.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_cubit.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_state.dart';
import 'package:boticario_news/ui/pages/signup/signup_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/mockito.dart';

class FormLoginCubitSpy extends MockBloc<FormLoginState>
    implements FormLoginCubit {}

class FormSignUpCubitSpy extends MockBloc<FormSignUpState>
    implements FormSignUpCubit {}

class FeedCubitSpy extends MockBloc<FeedState> implements FeedCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

main() {
  FormLoginCubitSpy formLoginCubit;
  MockNavigatorObserver navigatorObserver;
  FeedCubitSpy feedCubit;
  FormSignUpCubitSpy formSignCubit;

  setUp(() {
    formLoginCubit = FormLoginCubitSpy();
    formSignCubit = FormSignUpCubitSpy();
    feedCubit = FeedCubitSpy();
    navigatorObserver = MockNavigatorObserver();
  });

  Future loadPage(
    WidgetTester tester,
  ) async {
    final Map<String, WidgetBuilder> routes = {
      AppRoutes.signup: (_) => BlocProvider<FormSignUpCubit>.value(
            value: formSignCubit,
            child: SignUpPage(),
          ),
      AppRoutes.feed: (_) => BlocProvider<FeedCubit>.value(
            value: feedCubit,
            child: FeedPage(),
          ),
      AppRoutes.login: (_) => BlocProvider<FormLoginCubit>.value(
            value: formLoginCubit,
            child: LoginPage(),
          ),
    };

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.login,
        routes: routes,
        navigatorObservers: [navigatorObserver],
      ),
    );
  }

  testWidgets('Should call handles with correct values', (tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    await loadPage(tester);

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
    await loadPage(tester);
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
    await loadPage(tester);
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
    await loadPage(tester);
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
    await loadPage(tester);
    await tester.pump();

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should go to FeedPage if is Submission Success',
      (WidgetTester tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    whenListen<FormLoginState>(
      formLoginCubit,
      Stream.fromIterable(
        [FormLoginState(status: FormzStatus.submissionSuccess)],
      ),
    );

    await loadPage(tester);

    await tester.pumpAndSettle();

    verify(navigatorObserver.didPush(any, any));
    expect(find.byType(FeedPage), findsOneWidget);
  });

  testWidgets('Should show snackBar if unexpected error ocurrs',
      (tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    whenListen<FormLoginState>(
      formLoginCubit,
      Stream.fromIterable(
        [
          FormLoginState(
            errorMessage: UIError.unexpected.description,
            status: FormzStatus.submissionFailure,
          )
        ],
      ),
    );

    await loadPage(tester);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(UIError.unexpected.description), findsOneWidget);
  });

  testWidgets('Should go to SignupPage if tap in CreateAccountButton ',
      (WidgetTester tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());
    when(formLoginCubit.state).thenReturn(FormLoginState());

    await loadPage(tester);

    await tester.tap(find.text('Não tem conta? Cadastrar'));
    await tester.pump();

    verify(navigatorObserver.didPush(any, any));
    expect(find.byType(SignUpPage), findsOneWidget);
  });

  testWidgets('Should pop page if Icons.close pressed',
      (WidgetTester tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    await loadPage(tester);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    verify(navigatorObserver.didPop(any, any));
  });
}
