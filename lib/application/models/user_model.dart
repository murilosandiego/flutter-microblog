import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    this.id,
    this.name,
    this.profilePicture,
  });

  final String name;
  final String profilePicture;
  final int id;
}
