import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  UserEntity({
    this.id,
    this.name,
    this.profilePicture,
  });

  final int id;
  final String name;
  final String profilePicture;

  @override
  List<Object> get props => [id, name, profilePicture];
}
