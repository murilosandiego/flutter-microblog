import 'dart:convert';

import 'package:boticario_news/application/http/http_client.dart';
import 'package:boticario_news/application/http/http_error.dart';
import 'package:boticario_news/application/usecases/remote_load_news.dart';
import 'package:boticario_news/domain/entities/post_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  RemoteLoadNews sut;
  HttpClientMock httpClient;
  String url;

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();

    sut = RemoteLoadNews(
      httpClient: httpClient,
      url: url,
    );
  });

  test('Should call HttpClient with correct values', () async {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
      ),
    ).thenAnswer((_) async => jsonDecode(apiResponseNewsBoticario));

    await sut.load();

    verify(
      httpClient.request(
        url: url,
        method: 'get',
      ),
    );
  }, skip: true);

  test('Should return news on 200', () async {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
      ),
    ).thenAnswer((_) async => jsonDecode(apiResponseNewsBoticario));

    final news = await sut.load();

    expect(news, isA<List<PostEntity>>());
    expect(news[0].user.name, equals('O Boticário'));
  }, skip: true);

  test('Should throw UnexpectedError if HttpClient not returns 200', () {
    when(
      httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
      ),
    ).thenThrow(HttpError.serverError);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
