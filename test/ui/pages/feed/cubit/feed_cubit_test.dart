import 'package:bloc_test/bloc_test.dart';
import 'package:boticario_news/application/storage/local_storage.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:boticario_news/domain/usecases/load_posts.dart';
import 'package:boticario_news/domain/usecases/remove_post.dart';
import 'package:boticario_news/domain/usecases/save_post.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_cubit.dart';
import 'package:boticario_news/ui/pages/feed/cubit/feed_state.dart';
import 'package:boticario_news/ui/pages/feed/post_viewmodel.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks.dart';

class LoadPostsSpy extends Mock implements LoadPosts {}

class SavePostSpy extends Mock implements SavePost {}

class RemovePostSpy extends Mock implements RemovePost {}

class LocalStorageSpy extends Mock implements CacheLocalStorage {}

void main() {
  FeedCubit sut;
  LoadPostsSpy loadPosts;
  SavePostSpy savePost;
  RemovePostSpy removePost;
  LocalStorageSpy localStorage;
  String message;
  int postId;

  setUp(() {
    loadPosts = LoadPostsSpy();
    localStorage = LocalStorageSpy();
    message = faker.lorem.sentence();
    savePost = SavePostSpy();
    postId = faker.randomGenerator.integer(10);

    sut = FeedCubit(
      loadPosts: loadPosts,
      savePost: savePost,
      removePost: removePost,
      localStorage: localStorage,
    );
  });

  group('Load posts', () {
    mockSuccessPost() =>
        when(loadPosts.load()).thenAnswer((_) async => newsList);

    mockError() => when(loadPosts.load()).thenThrow(DomainError.unexpected);

    blocTest(
      'Should call loadPosts() once when load',
      build: () {
        mockSuccessPost();
        return sut;
      },
      act: (sut) => sut.load(),
      verify: (_) {
        verify(loadPosts.load()).called(1);
      },
    );

    blocTest(
      'Should emits FeedLoaded on success',
      build: () {
        mockSuccessPost();
        return sut;
      },
      act: (sut) => sut.load(),
      expect: [FeedLoaded(news: postsViewModel)],
    );

    blocTest(
      'Should emits FeedLoaded on failure',
      build: () {
        mockError();
        return sut;
      },
      act: (sut) => sut.load(),
      expect: [
        FeedError(UIError.unexpected.description),
      ],
    );
  });

  group('Logout user', () {
    mockLocalStorageError() =>
        when(localStorage.clear()).thenThrow(DomainError.unexpected);

    blocTest(
      'Should emits [FeedLoading, LogoutUser] on logoutUser',
      build: () {
        return sut;
      },
      act: (sut) => sut.logoutUser(),
      expect: [
        FeedLoading(),
        LogoutUser(),
      ],
    );

    blocTest<FeedCubit, FeedState>(
      'Should emits [FeedLoading, FeedError] on failure',
      build: () {
        mockLocalStorageError();
        return sut;
      },
      act: (sut) => sut.logoutUser(),
      expect: [
        FeedLoading(),
        FeedError(UIError.unexpected.description),
      ],
    );

    blocTest<FeedCubit, FeedState>(
      'Should call localStorage.clear() with success',
      build: () => sut,
      act: (sut) => sut.logoutUser(),
      verify: (_) {
        verify(localStorage.clear()).called(1);
      },
    );
  });

  group('Create post', () {
    mockSavePost() => when(savePost.save(
          message: anyNamed('message'),
        )).thenAnswer(
          (_) async => mockPost,
        );

    mockSavePostError() => when(savePost.save(message: anyNamed('message')))
        .thenThrow(DomainError.unexpected);

    blocTest<FeedCubit, FeedState>(
      'Should call SavePost once when create a post',
      build: () {
        return sut;
      },
      act: (sut) => sut.handleSavePost(message: message),
      verify: (_) {
        verify(savePost.save(message: message)).called(1);
      },
    );

    blocTest<FeedCubit, FeedState>(
      'Should update list of Posts when create a post',
      build: () {
        mockSavePost();
        return sut;
      },
      seed: FeedLoaded(news: postsViewModel),
      act: (sut) => sut.handleSavePost(message: message),
      expect: [
        FeedLoaded(
          news: List.of(postsViewModel)
            ..insert(
              0,
              NewsViewModel(
                id: mockPost.id,
                message: mockPost.message.content,
                date:
                    'January ${mockPost.message.createdAt.day}, ${mockPost.message.createdAt.year}',
                user: mockPost.user.name,
                userId: mockPost.user.id,
              ),
            ),
        )
      ],
    );

    blocTest<FeedCubit, FeedState>(
      'Should emtis [FeedLoading, FeedError] if it fails when create post',
      build: () {
        mockSavePostError();
        return sut;
      },
      act: (sut) => sut.handleSavePost(message: message, postId: postId),
      expect: [
        FeedError(UIError.unexpected.description),
      ],
    );
  });

  group('Update post', () {
    mockEditPost() => when(
          savePost.save(
              message: anyNamed('message'), postId: anyNamed('postId')),
        ).thenAnswer(
          (_) async => newsList[1].copyWith(
              message: newsList[1].message.copyWith(content: 'Editada'), id: 2),
        );

    blocTest<FeedCubit, FeedState>(
      'Should call SavePost once when update a post',
      build: () {
        return sut;
      },
      act: (sut) => sut.handleSavePost(message: message, postId: postId),
      verify: (_) {
        verify(savePost.save(message: message, postId: postId)).called(1);
      },
    );

    blocTest<FeedCubit, FeedState>(
      'Should update a list of posts',
      build: () {
        mockEditPost();
        return sut;
      },
      seed: FeedLoaded(news: postsViewModel),
      act: (sut) => sut.handleSavePost(message: message, postId: 2),
      expect: [
        FeedLoaded(news: postsViewModelEdited),
      ],
    );
  });
}
