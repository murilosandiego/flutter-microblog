import 'ui_error.dart';

class Validator {
  static UIError emailField(String field) {
    if (field == null) {
      return null;
    }

    if (field.isEmpty == true) {
      return UIError.requiredField;
    }

    return null;
    // return field.isEmail == true ? null : UIError.invalidEmail;
  }

  static UIError requiredField(String field) {
    return field?.isEmpty == true ? UIError.requiredField : null;
  }
}
