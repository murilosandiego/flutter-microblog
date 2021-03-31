import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

class AccountEntity extends Equatable {
  final String token;
  final String username;
  final String email;
  final int id;

  AccountEntity(
      {@required this.token,
      @required this.id,
      @required this.username,
      @required this.email});

  @override
  List get props => [token, id, username, email];
}
