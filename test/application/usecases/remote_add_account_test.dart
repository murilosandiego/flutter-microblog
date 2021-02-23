import 'dart:convert';

import 'package:boticario_news/application/usecases/remote_add_account.dart';
import 'package:boticario_news/domain/usecases/add_account.dart';
import 'package:faker/faker.dart';
import 'package:boticario_news/application/http/http_client.dart';
import 'package:boticario_news/application/http/http_error.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  RemoteAddAccount sut;
  HttpClientMock httpClient;
  String url;
  AddAccountParams params;

  mockSuccess() => when(httpClient.request(
              url: anyNamed('url'),
              method: anyNamed('method'),
              body: anyNamed('body')))
          .thenAnswer(
        (_) async => jsonDecode(factoryApiResponse),
      );

  mockError(HttpError error) => when(httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
          body: anyNamed('body')))
      .thenThrow(error);

  setUp(() {
    httpClient = HttpClientMock();
    url = faker.internet.httpUrl();

    sut = RemoteAddAccount(
      httpClient: httpClient,
      url: url,
    );
    params = AddAccountParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
      name: faker.person.name(),
    );

    mockSuccess();
  });

  test('should call HttpClient with correct values', () async {
    await sut.add(params);

    verify(
      httpClient.request(
        url: url,
        method: 'post',
        body: {
          'username': params.name,
          'email': params.email,
          'password': params.secret
        },
      ),
    );
  });

  test('should throw UnexpectedError if HttpClient returns 400', () {
    mockError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient returns 404', () {
    mockError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient returns 500', () {
    mockError(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw InvalidCredentialsError if HttpClient returns 401', () {
    mockError(HttpError.unauthorized);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('should return an Account if HttpClient returns 200', () async {
    final account = await sut.add(params);

    expect(account.token, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9');
    expect(account.username, 'juca');
    expect(account.id, 2);
  });
}
