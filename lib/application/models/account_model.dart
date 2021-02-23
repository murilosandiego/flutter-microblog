import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

import '../../domain/entities/account_entity.dart';

class AccountModel extends AccountEntity implements Equatable {
  final String token;
  final String username;
  final int id;

  AccountModel({
    @required this.token,
    @required this.username,
    @required this.id,
  });

  factory AccountModel.fromJson(json) => AccountModel(
      token: json["jwt"],
      username: json["user"]["username"],
      id: json["user"]["id"]);

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'username': username,
      'id': id,
    };
  }

  factory AccountModel.fromLocalStorage(json) => AccountModel(
        token: json["token"],
        username: json["username"],
        id: json["id"],
      );

  AccountEntity toEntity() => AccountEntity(
        token: token,
        id: id,
        username: username,
      );
}
