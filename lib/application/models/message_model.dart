import 'dart:convert' show utf8;

import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    this.content,
    this.createdAt,
  });

  final String content;
  final DateTime createdAt;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    String content = json["content"];
    String contentDecoded = utf8.decode(content.runes?.toList());
    return MessageModel(
      content: contentDecoded,
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "content": content,
        "created_at": createdAt.toIso8601String(),
      };
}
