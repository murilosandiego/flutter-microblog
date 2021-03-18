import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show required;

class NewsViewModel extends Equatable {
  final String message;
  final String date;
  final String user;
  final int id;
  final int userId;

  NewsViewModel({
    @required this.message,
    @required this.date,
    @required this.user,
    this.id,
    this.userId,
  });

  @override
  List get props => [message, date, user, id, userId];

  @override
  bool get stringify => true;

  NewsViewModel copyWith({
    String message,
    String date,
    String user,
    int id,
    int userId,
  }) {
    return NewsViewModel(
      message: message ?? this.message,
      date: date ?? this.date,
      user: user ?? this.user,
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }
}
