import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/domain/usecases/load_news.dart';
import 'package:boticario_news/domain/usecases/load_posts.dart';
import 'package:boticario_news/domain/usecases/remove_post.dart';
import 'package:boticario_news/domain/usecases/save_post.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LoadNewsSpy extends Mock implements LoadNews {}

class LoadPostsSpy extends Mock implements LoadPosts {}

class SavePostSpy extends Mock implements SavePost {}

class RemovePostSpy extends Mock implements RemovePost {}

void main() {
  FeedCubit sut;
  LoadNewsSpy loadNews;
  LoadPostsSpy loadPosts;
  SavePostSpy savePost;
  RemovePostSpy removePost;

  // mockSuccess() => when(loadNews.load()).thenAnswer((_) async => newsList);

  // mockSuccessPost() => when(loadPosts.load()).thenAnswer((_) async => newsList);

  // mockError() => when(loadNews.load()).thenThrow(DomainError.unexpected);

  setUp(() {
    loadNews = LoadNewsSpy();
    loadPosts = LoadPostsSpy();

    sut = FeedCubit(
      loadNews: loadNews,
      loadPosts: loadPosts,
      savePost: savePost,
      removePost: removePost,
    );
  });

  // test('Should call loadNews on loadData', () async {
  //   mockSuccess();
  //   await sut.load();

  //   verify(loadNews.load()).called(1);
  // });

  blocTest(
    'Should call loadNews() and loadPosts() when load is call ',
    build: () => sut,
    act: (cubit) => cubit.load(),
    verify: (_) {
      verify(loadNews.load()).called(1);
      verify(loadPosts.load()).called(1);
    },
  );

  // test('Should call loadPosts on loadData', () async {
  //   mockSuccessPost();
  //   await sut.load();

  //   verify(loadPosts.load()).called(1);
  // });

  // test('Should return false if the message size is greater than 280', () {
  //   final validMessage = faker.randomGenerator.string(300, min: 281);

  //   sut.handleNewPostMessage(validMessage);

  //   expect(sut.isFormValid, false);
  //   expect(sut.errorMessageNewPost, UIError.invalidMessageNewPost);
  // });

  // test('Should return true if the message size is less or equal than 280', () {
  //   final validMessage = faker.randomGenerator.string(280);

  //   sut.handleNewPostMessage(validMessage);

  //   expect(sut.isFormValid, true);
  // });

  // test('Should set UIError.unexpected if throws', () async {
  //   mockError();

  //   await sut.load();

  //   expect(sut.errorMessage, UIError.unexpected.description);
  // });
}
