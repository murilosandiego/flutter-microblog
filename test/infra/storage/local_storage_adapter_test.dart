import 'package:boticario_news/infra/storage/local_storage_adater.dart';
import 'package:faker/faker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class LocalStorageSpy extends Mock implements SharedPreferences {}

main() {
  LocalStorageSpy localStorage;
  LocalStorageAdapter sut;
  String key;
  String value;

  setUp(() {
    localStorage = LocalStorageSpy();
    sut = LocalStorageAdapter(localStorage: localStorage);

    key = faker.randomGenerator.string(4);
    value = faker.randomGenerator.string(10);
  });

  group('Save method', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.save(key: key, value: value);

      verify(localStorage.setString(key, value));
    });

    test('Should throw Exception if LocalStorage fails', () {
      when(localStorage.setString(any, any)).thenThrow(Exception());

      final future = sut.save(key: key, value: value);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('Fetch method', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.fetch(key: key);

      verify(localStorage.getString(key));
    });

    test('Should return a value with success', () async {
      when(localStorage.getString(any)).thenAnswer((_) => value);

      final valueResult = await sut.fetch(key: key);

      expect(valueResult, value);
    });

    test('Should throw Exception if LocalStorage fails', () {
      when(localStorage.getString(any)).thenThrow(Exception());

      final future = sut.fetch(key: key);

      expect(future, throwsA(TypeMatcher<Exception>()));
    });
  });

  group('Clear method', () {
    test('Should call LocalStorage with correct values', () async {
      await sut.clear();

      verify(localStorage.clear());
    });

    test('Should throw Exception if LocalStorage fails', () {
      when(localStorage.clear()).thenThrow(Exception());

      final future = sut.clear();

      expect(future, throwsA(isA<Exception>()));
    });
  });
}
