import 'dart:convert';

import 'package:boticario_news/application/models/account_model.dart';
import 'package:faker/faker.dart';
import 'package:boticario_news/application/storage/local_storage.dart';
import 'package:boticario_news/application/usecases/local_save_current_account.dart';
import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:boticario_news/domain/errors/domain_error.dart';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalStorageSpy extends Mock implements CacheLocalStorage {}

void main() {
  LocalStorageSpy localStorage;
  LocalSaveCurrentAccount sut;
  AccountEntity account;

  setUp(() {
    localStorage = LocalStorageSpy();
    sut = LocalSaveCurrentAccount(localStorage: localStorage);
    account = AccountEntity(
        token: faker.guid.guid(),
        id: faker.randomGenerator.integer(3),
        username: faker.person.name(),
        email: faker.internet.email());
  });

  test('Should call the save method of LocalStorage with correct values',
      () async {
    final accountModel = AccountModel(
        token: account.token,
        username: account.username,
        id: account.id,
        email: account.email);

    await sut.save(account);

    verify(localStorage.save(
      key: 'account',
      value: jsonEncode(accountModel.toJson()),
    ));
  });

  test('Should throw UnexpectedError if LocalStorage throws', () {
    when(localStorage.save(key: anyNamed('key'), value: anyNamed('value')))
        .thenThrow(Exception());

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
