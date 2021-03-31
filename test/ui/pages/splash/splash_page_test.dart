import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/main/routes/app_routes.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_cubit.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_state.dart';
import 'package:boticario_news/ui/pages/feed/feed_page.dart';
import 'package:boticario_news/ui/pages/splash/cubit/splash_cubit.dart';
import 'package:boticario_news/ui/pages/splash/cubit/splash_state.dart';
import 'package:boticario_news/ui/pages/splash/splash_page.dart';
import 'package:boticario_news/ui/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SplashCubitSpy extends MockBloc<SplashState> implements SplashCubit {}

class FeedCubitSpy extends MockBloc<FeedState> implements FeedCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

main() {
  SplashCubitSpy splashCubit;
  MockNavigatorObserver navigatorObserver;
  FeedCubitSpy feedCubit;

  setUp(() {
    splashCubit = SplashCubitSpy();
    feedCubit = FeedCubitSpy();
    navigatorObserver = MockNavigatorObserver();
  });

  Future loadPage(
    WidgetTester tester,
  ) async {
    final Map<String, WidgetBuilder> routes = {
      AppRoutes.welcome: (_) => WelcomePage(),
      AppRoutes.splash: (_) => BlocProvider<SplashCubit>.value(
            value: splashCubit,
            child: SplashPage(),
          ),
      AppRoutes.feed: (_) => BlocProvider<FeedCubit>.value(
            value: feedCubit,
            child: FeedPage(),
          ),
    };

    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.splash,
        routes: routes,
        navigatorObservers: [navigatorObserver],
      ),
    );
  }

  testWidgets('Should go to WelcomePage if state is SplashToWelcome',
      (WidgetTester tester) async {
    when(splashCubit.state).thenReturn(SplashInitial());

    whenListen<SplashState>(
      splashCubit,
      Stream.fromIterable(
        [SplashToWelcome()],
      ),
    );

    await loadPage(tester);

    await tester.pumpAndSettle();

    verify(navigatorObserver.didPush(any, any));
    expect(find.byType(WelcomePage), findsOneWidget);
  });

  testWidgets('Should go to FeedPage if state is SplashToHome',
      (WidgetTester tester) async {
    when(splashCubit.state).thenReturn(SplashInitial());

    whenListen<SplashState>(
      splashCubit,
      Stream.fromIterable(
        [SplashToHome()],
      ),
    );

    await loadPage(tester);

    await tester.pumpAndSettle();

    verify(navigatorObserver.didPush(any, any));
    expect(find.byType(FeedPage), findsOneWidget);
  });
}
