import 'dart:convert';

import 'package:boticario_news/application/http/http_client.dart';
import 'package:boticario_news/application/http/http_error.dart';
import 'package:boticario_news/application/usecases/remote_load_posts.dart';
import 'package:boticario_news/domain/entities/post_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  RemoteLoadPosts sut;
  HttpClientMock httpClient;
  String url;

  mockSuccess() => when(
        httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
        ),
      ).thenAnswer((_) async => jsonDecode(apiResponsePosts));

  mockError() => when(
        httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
        ),
      ).thenThrow(HttpError.serverError);

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();

    sut = RemoteLoadPosts(
      httpClient: httpClient,
      url: url,
    );

    mockSuccess();
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(
      httpClient.request(
        url: url,
        method: 'get',
      ),
    );
  });

  test('Should return news on 200', () async {
    final news = await sut.load();

    expect(news, isA<List<PostEntity>>());
    expect(news[1].user.name, equals('juca'));
    expect(news[1].message.content, equals('Vai que da'));
  });

  test('Should throw UnexpectedError if HttpClient not returns 200', () {
    mockError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
