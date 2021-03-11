import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:flutter/foundation.dart';

class UserManager extends ChangeNotifier {
  String _username;
  int _id;

  addUser(AccountEntity account) {
    _username = account.username;
    _id = account.id;
    notifyListeners();
  }

  removeUser() {
    _username = null;
    _id = null;
    notifyListeners();
  }

  String get username => _username;
  int get id => _id;
}
