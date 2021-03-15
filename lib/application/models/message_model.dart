import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    this.content,
    this.createdAt,
  });

  final String content;
  final DateTime createdAt;
}
