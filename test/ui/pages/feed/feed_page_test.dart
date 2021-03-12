import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:boticario_news/main/routes/app_routes.dart';
import 'package:boticario_news/ui/helpers/user_manager.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_cubit.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_state.dart';
import 'package:boticario_news/ui/pages/feed/feed_page.dart';
import 'package:boticario_news/ui/pages/feed/post_viewmodel.dart';
import 'package:boticario_news/ui/pages/welcome/welcome_page.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class FeedCubitSpy extends MockBloc<FeedState> implements FeedCubit {}

class NavigatorObserverSpy extends Mock implements NavigatorObserver {}

main() {
  FeedCubitSpy feedCubit;
  NavigatorObserver navigatorObserver;
  String user;
  String email;
  String message;

  setUp(() {
    feedCubit = FeedCubitSpy();
    user = faker.person.name();
    email = faker.internet.email();
    navigatorObserver = NavigatorObserverSpy();
    message = faker.lorem.sentence();
  });

  Future _loadPage(WidgetTester tester) async {
    final Map<String, WidgetBuilder> routes = {
      AppRoutes.feed: (_) => FeedPage(),
      AppRoutes.welcome: (_) => WelcomePage(),
    };

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => UserManager()
          ..addUser(
            AccountEntity(token: '', id: 1, username: user, email: email),
          ),
        child: MultiBlocProvider(
          providers: [BlocProvider<FeedCubit>.value(value: feedCubit)],
          child: MaterialApp(
            initialRoute: AppRoutes.feed,
            routes: routes,
            navigatorObservers: [navigatorObserver],
          ),
        ),
      ),
    );
  }

  testWidgets('Should show loading when states is FeedLoading',
      (WidgetTester tester) async {
    when(feedCubit.state).thenAnswer((_) => FeedLoading());

    await _loadPage(tester);

    final loading = find.byType(CircularProgressIndicator);
    expect(loading, findsOneWidget);
  });

  testWidgets('Should show empty list when state is FeedLoaded with no posts',
      (WidgetTester tester) async {
    when(feedCubit.state).thenAnswer((_) => FeedLoaded([]));

    await _loadPage(tester);

    final listView = find.byType(ListView);
    expect(listView, findsOneWidget);
    expect(
        (listView.evaluate().first.widget as ListView).semanticChildCount, 0);
  });

  testWidgets('Should show list when state is FeedLoaded with posts',
      (WidgetTester tester) async {
    when(feedCubit.state)
        .thenAnswer((_) => FeedLoaded(_newsMock(message, user)));

    await _loadPage(tester);

    final listView = find.byType(ListView);
    expect(listView, findsOneWidget);
    expect(
        (listView.evaluate().first.widget as ListView).semanticChildCount, 2);
    expect(find.text(message), findsOneWidget);
    expect(find.text(user), findsOneWidget);
  });

  testWidgets('Should show ReloadScreen widget when states is FeedError',
      (WidgetTester tester) async {
    when(feedCubit.state).thenAnswer((_) => FeedError('error'));

    await _loadPage(tester);

    expect(find.text('error'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
  });

  testWidgets('Should call loadPosts on reload click',
      (WidgetTester tester) async {
    when(feedCubit.state).thenAnswer((_) => FeedError('error'));

    await _loadPage(tester);
    await tester.tap(find.text('Recarregar'));
    verify(feedCubit.load()).called(2);
  });

  testWidgets('Should show Drawer when tap in menu icon',
      (WidgetTester tester) async {
    await _loadPage(tester);

    final menuIcon = find.byIcon(Icons.menu);
    expect(menuIcon, findsOneWidget);

    await tester.tap(menuIcon);
    await tester.pump();

    expect(find.byType(Drawer), findsOneWidget);
    expect(find.text(user), findsOneWidget);
    expect(find.text(email), findsOneWidget);
  });

  testWidgets('Should call logoutUser when tap in Sair',
      (WidgetTester tester) async {
    when(feedCubit.state).thenReturn(FeedInitial());

    await _loadPage(tester);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    final exit = find.text('Sair');
    expect(exit, findsOneWidget);
  });

  testWidgets('Should navigate to WelcomePage if state is LogoutUser',
      (WidgetTester tester) async {
    when(feedCubit.state).thenReturn(FeedInitial());

    whenListen<FeedState>(
      feedCubit,
      Stream.fromIterable(
        [
          LogoutUser(),
        ],
      ),
    );

    await _loadPage(tester);
    await tester.pumpAndSettle();

    verify(navigatorObserver.didPush(any, any));
    expect(find.byType(WelcomePage), findsOneWidget);
  });

  testWidgets('Should call loadPosts if fling RefreshIndicator',
      (WidgetTester tester) async {
    when(feedCubit.state)
        .thenAnswer((_) => FeedLoaded(_newsMock(message, user)));

    when(feedCubit.load())
        .thenAnswer((_) async => Future.delayed(Duration.zero));

    await _loadPage(tester);

    await tester.fling(find.text(message), const Offset(0.0, 300.0), 1000.0);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    verify(feedCubit.load());
  });
}

List<NewsViewModel> _newsMock(String message, String user) {
  return [
    NewsViewModel(
      message: message,
      date: 'January, 20 2020',
      user: user,
    ),
    NewsViewModel(
      message: faker.lorem.sentence(),
      date: 'January, 20 2010',
      user: faker.person.name(),
    )
  ];
}
