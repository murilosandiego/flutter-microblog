import 'package:equatable/equatable.dart';

import 'message_entity.dart';
import 'user_entity.dart';

class PostEntity extends Equatable {
  PostEntity({
    this.id,
    this.user,
    this.message,
  });

  final UserEntity user;
  final MessageEntity message;
  final int id;

  @override
  List get props => [user, message, id];

  PostEntity copyWith({
    UserEntity user,
    MessageEntity message,
    int id,
  }) {
    return PostEntity(
      user: user ?? this.user,
      message: message ?? this.message,
      id: id ?? this.id,
    );
  }
}
