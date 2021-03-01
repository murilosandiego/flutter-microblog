import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/main/routes/app_routes.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_cubit.dart';
import 'package:boticario_news/ui/pages/login/cubit/form_state.dart';
import 'package:boticario_news/ui/pages/login/login_page.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_cubit.dart';
import 'package:boticario_news/ui/pages/signup/cubit/form_signup_state.dart';
import 'package:boticario_news/ui/pages/signup/signup_page.dart';
import 'package:boticario_news/ui/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FormLoginCubitSpy extends MockBloc<FormLoginState>
    implements FormLoginCubit {}

class FormSignUpCubitSpy extends MockBloc<FormSignUpState>
    implements FormSignUpCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

main() {
  FormLoginCubitSpy formLoginCubit;
  MockNavigatorObserver navigatorObserver;
  FormSignUpCubitSpy formSignCubit;

  setUp(() {
    formLoginCubit = FormLoginCubitSpy();
    formSignCubit = FormSignUpCubitSpy();
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
      AppRoutes.login: (_) => BlocProvider<FormLoginCubit>.value(
            value: formLoginCubit,
            child: LoginPage(),
          ),
      AppRoutes.welcome: (_) => WelcomePage(),
    };

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.welcome,
        routes: routes,
        navigatorObservers: [navigatorObserver],
      ),
    );
  }

  testWidgets('Should go to SignupPage if tap in CreateAccountButton ',
      (WidgetTester tester) async {
    when(formSignCubit.state).thenReturn(FormSignUpState());

    await loadPage(tester);

    await tester.tap(find.text('Não tem conta? Cadastrar'));
    await tester.pumpAndSettle();

    verify(navigatorObserver.didPush(any, any));
    expect(find.byType(SignUpPage), findsOneWidget);
  });

  testWidgets('Should go to LoginPage if tap in Fazer Login',
      (WidgetTester tester) async {
    when(formLoginCubit.state).thenReturn(FormLoginState());

    await loadPage(tester);

    await tester.tap(find.text('Fazer login'));
    await tester.pumpAndSettle();

    verify(navigatorObserver.didPush(any, any));
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
