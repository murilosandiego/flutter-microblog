import '../../domain/entities/post_entity.dart';
import 'message_model.dart';
import 'user_model.dart';

class PostModel extends PostEntity {
  PostModel({
    this.user,
    this.message,
    this.id,
  });

  final UserModel user;
  final MessageModel message;
  final int id;

  factory PostModel.fromJsonApiPosts(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        user: json["users_permissions_user"] == null
            ? null
            : UserModel(
                name: json["users_permissions_user"]["username"],
                id: json["users_permissions_user"]["id"],
              ),
        message: MessageModel(
            content: json["message"]["content"],
            createdAt: DateTime.parse(json["created_at"])),
      );
}
