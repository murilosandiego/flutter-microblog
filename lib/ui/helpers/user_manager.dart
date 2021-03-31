import 'package:boticario_news/domain/entities/account_entity.dart';
import 'package:flutter/foundation.dart';

class UserManager extends ChangeNotifier {
  String _username;
  String _email;
  int _id;

  void addUser(AccountEntity account) {
    _username = account.username;
    _id = account.id;
    _email = account.email;
    notifyListeners();
  }

  String get username => _username;
  String get email => _email;
  int get id => _id;
}
