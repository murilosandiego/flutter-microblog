import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

class AccountEntity extends Equatable {
  final String token;
  final String username;
  final int id;

  AccountEntity({
    @required this.token,
    @required this.id,
    @required this.username,
  });

  @override
  List get props => [token];

  @override
  bool get stringify => true;
}
