import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_cubit.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_state.dart';
import 'package:boticario_news/ui/pages/feed/feed_page.dart';
import 'package:boticario_news/ui/pages/feed/post_viewmodel.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FeedCubitSpy extends MockBloc<FeedState> implements FeedCubit {}

main() {
  FeedCubitSpy feedCubit;
  setUp(() {
    feedCubit = FeedCubitSpy();
  });
  testWidgets('Should show loading when states is FeedLoading',
      (WidgetTester tester) async {
    when(feedCubit.state).thenAnswer((_) => FeedLoading());

    await _loadPage(tester, feedCubit);

    final loading = find.byType(CircularProgressIndicator);
    expect(loading, findsOneWidget);
  });

  testWidgets('Should show empty list when state is FeedLoaded with no posts',
      (WidgetTester tester) async {
    when(feedCubit.state).thenAnswer((_) => FeedLoaded([]));

    await _loadPage(tester, feedCubit);

    final listView = find.byType(ListView);
    expect(listView, findsOneWidget);
    expect(
        (listView.evaluate().first.widget as ListView).semanticChildCount, 0);
  });

  testWidgets('Should show list when state is FeedLoaded with posts',
      (WidgetTester tester) async {
    final message = faker.lorem.sentence();
    final user = faker.person.name();
    when(feedCubit.state).thenAnswer((_) => FeedLoaded([
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
        ]));

    await _loadPage(tester, feedCubit);

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

    await _loadPage(tester, feedCubit);

    expect(find.text('error'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
  });

  testWidgets('Should call loadPosts on reload click',
      (WidgetTester tester) async {
    when(feedCubit.state).thenAnswer((_) => FeedError('error'));

    await _loadPage(tester, feedCubit);
    await tester.tap(find.text('Recarregar'));
    verify(feedCubit.load()).called(2);
  });
}

Future _loadPage(WidgetTester tester, FeedCubitSpy feedCubit) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiBlocProvider(
        providers: [BlocProvider<FeedCubit>.value(value: feedCubit)],
        child: FeedPage(),
      ),
    ),
  );
}
