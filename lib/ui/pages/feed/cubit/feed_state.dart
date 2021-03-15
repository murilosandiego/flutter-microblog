import 'package:equatable/equatable.dart';

import '../post_viewmodel.dart';

abstract class FeedState extends Equatable {}

class FeedInitial extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {
  @override
  List<Object> get props => [];
}

class FeedLoaded extends FeedState {
  final List<NewsViewModel> news;

  FeedLoaded({this.news});
  @override
  List<Object> get props => [news];

  @override
  bool get stringify => true;
}

class FeedError extends FeedState {
  final String message;

  FeedError(this.message);
  @override
  List<Object> get props => [message];
}

class LogoutUser extends FeedState {
  @override
  List<Object> get props => [];
}
