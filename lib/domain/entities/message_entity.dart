import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  MessageEntity({
    this.content,
    this.createdAt,
  });

  final String content;
  final DateTime createdAt;

  @override
  List get props => [content, createdAt];

  MessageEntity copyWith({
    String content,
    DateTime createdAt,
  }) {
    return MessageEntity(
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
