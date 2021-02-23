import 'dart:convert';

import 'package:boticario_news/application/http/http_client.dart';
import 'package:boticario_news/application/http/http_error.dart';
import 'package:boticario_news/application/usecases/remote_save_post.dart';
import 'package:boticario_news/domain/entities/post_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  RemoteSavePost sut;
  HttpClientMock httpClient;
  String url;
  String message;
  // Map body;

  mockSuccess() => when(httpClient.request(
              url: anyNamed('url'),
              method: anyNamed('method'),
              body: anyNamed('body')))
          .thenAnswer(
        (_) async => jsonDecode(factoryNewPostApiResponse),
      );

  mockError(HttpError error) => when(httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
          body: anyNamed('body')))
      .thenThrow(error);

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();

    sut = RemoteSavePost(
      httpClient: httpClient,
      url: url,
    );

    message = faker.randomGenerator.string(280);

    // body = {
    //   "message": {"content": message},
    //   "users_permissions_user": {"id": 1}
    // };

    mockSuccess();
  });

  group('Create Post', () {
    test('should return an PostEntity if HttpClient returns 200', () async {
      final post = await sut.save(message: message);

      expect(post, isA<PostEntity>());
      expect(post.user.name, equals('user'));
      expect(post.message.content, equals('message'));
    });

    test('should throw UnexpectedError if HttpClient not return 200', () {
      mockError(HttpError.badRequest);

      final future = sut.save(message: message);

      expect(future, throwsA(DomainError.unexpected));
    });
  });
}
