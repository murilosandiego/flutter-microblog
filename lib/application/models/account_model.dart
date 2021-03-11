import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

import '../../domain/entities/account_entity.dart';

class AccountModel extends AccountEntity implements Equatable {
  final String token;
  final String username;
  final int id;
  final String email;

  AccountModel({
    @required this.token,
    @required this.username,
    @required this.id,
    @required this.email,
  });

  factory AccountModel.fromJson(json) => AccountModel(
      token: json["jwt"],
      username: json["user"]["username"],
      email: json["user"]["email"],
      id: json["user"]["id"]);

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'email': email,
      'id': id,
    };
  }

  factory AccountModel.fromLocalStorage(json) => AccountModel(
        token: json["token"],
        username: json["username"],
        email: json["email"],
        id: json["id"],
      );

  AccountEntity toEntity() => AccountEntity(
        token: token,
        id: id,
        username: username,
        email: email,
      );
}
