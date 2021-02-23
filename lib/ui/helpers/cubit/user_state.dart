part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLogged extends UserState {
  final User user;

  UserLogged(this.user);
}

class User {
  final String name;
  final int id;

  User(this.name, this.id);
}
