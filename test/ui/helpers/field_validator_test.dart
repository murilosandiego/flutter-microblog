import 'package:boticario_news/ui/helpers/field_validator.dart';
import 'package:boticario_news/ui/helpers/ui_error.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

void main() {
  group('emailField', () {
    test('Should returns null if email null', () {
      String email;
      final validator = Validator.emailField(email);

      expect(validator, null);
    });

    test('Should returns requiredFieldError if email is empty', () {
      const email = '';
      final validator = Validator.emailField(email);

      expect(validator, UIError.requiredField);
    });

    test('Should return invalidEmail if email is not valid', () {
      String email = 'asdf';
      final validator = Validator.emailField(email);

      expect(validator, UIError.invalidEmail);
    });

    test('Should return null if validation succeeds', () {
      String email = faker.internet.email();

      final validator = Validator.emailField(email);
      expect(validator, null);
    });
  });

  group('requiredField', () {
    test('Should return null if field null', () {
      String field;

      final validator = Validator.requiredField(field);

      expect(validator, null);
    });

    test('Should return requiredFieldError if field is empty', () {
      const field = '';

      final validator = Validator.requiredField(field);

      expect(validator, UIError.requiredField);
    });

    test('Should return null if field is not empty', () {
      const field = 'asdf';

      final validator = Validator.requiredField(field);

      expect(validator, null);
    });
  });
}
