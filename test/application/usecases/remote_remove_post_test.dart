import 'package:boticario_news/application/http/http_client.dart';
import 'package:boticario_news/application/http/http_error.dart';
import 'package:boticario_news/application/usecases/remote_remove_post.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  RemoteRemovePost sut;
  HttpClientMock httpClient;
  String url;
  int postId;

  mockSuccess() => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
      )).thenAnswer(
        (_) async => true,
      );

  mockError(HttpError error) => when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
      )).thenThrow(error);

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();

    sut = RemoteRemovePost(
      httpClient: httpClient,
      url: url,
    );

    postId = faker.randomGenerator.integer(23);

    mockSuccess();
  });

  test('Should call HttpClient with correct values', () async {
    await sut.remove(postId: postId);

    verify(
      httpClient.request(
        url: '$url/$postId',
        method: 'delete',
      ),
    );
  });

  test('should throw UnexpectedError if HttpClient not return 200', () {
    mockError(HttpError.badRequest);

    final future = sut.remove(postId: postId);

    expect(future, throwsA(DomainError.unexpected));
  });
}
