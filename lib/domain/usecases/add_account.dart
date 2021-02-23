import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

import '../entities/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams extends Equatable {
  final String name;
  final String email;
  final String secret;

  AddAccountParams({
    @required this.name,
    @required this.email,
    @required this.secret,
  });

  @override
  List get props => [email, secret, name];
}
