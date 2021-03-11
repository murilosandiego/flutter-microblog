import 'dart:convert';

import 'package:boticario_news/application/models/account_model.dart';
import 'package:faker/faker.dart';
import 'package:boticario_news/application/storage/local_storage.dart';
import 'package:boticario_news/application/usecases/local_load_current_account.dart';
import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalStorageSpy extends Mock implements CacheLocalStorage {}

void main() {
  LocalStorageSpy localStorage;
  LocalLoadCurrentAccount sut;
  String token;
  String username;
  int id;
  String email;

  mockSuccess(accountModel) {
    final accountEncoded = jsonEncode(accountModel.toJson());

    when(localStorage.fetch(key: anyNamed('key')))
        .thenAnswer((_) async => accountEncoded);
  }

  setUp(() {
    localStorage = LocalStorageSpy();
    sut = LocalLoadCurrentAccount(localStorage: localStorage);
    token = faker.guid.guid();
    email = faker.internet.email();
    username = faker.person.name();
    id = faker.randomGenerator.integer(2);

    final accountModel =
        AccountModel(token: token, username: username, id: id, email: email);

    mockSuccess(accountModel);
  });

  test('Should call LocalStorage with currect value', () async {
    await sut.load();

    verify(localStorage.fetch(key: 'account'));
  });

  test('Shoud return an AccountEntity', () async {
    final account = await sut.load();

    expect(account,
        AccountEntity(token: token, username: username, id: id, email: email));
  });

  test('Shoud throw DomainError.unexpected if LocalStorage throws', () {
    when(localStorage.fetch(key: anyNamed('key')))
        .thenThrow(DomainError.unexpected);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });
}
