import 'dart:convert' show utf8;

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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String name = json["name"];
    String nameDecoded = utf8.decode(name.runes?.toList());
    return UserModel(
      name: nameDecoded,
      profilePicture: json["profile_picture"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "profile_picture": profilePicture,
      };

  @override
  List get props => [name, profilePicture];

  @override
  bool get stringify => true;
}
