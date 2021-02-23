import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/post_entity.dart';
import '../../../../domain/usecases/load_news.dart';
import '../../../../domain/usecases/load_posts.dart';
import '../../../../domain/usecases/remove_post.dart';
import '../../../../domain/usecases/save_post.dart';
import '../../../helpers/ui_error.dart';
import '../post_viewmodel.dart';
import 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final LoadNews loadNews;
  final LoadPosts loadPosts;
  final SavePost savePost;
  final RemovePost removePost;
  final LocalStorage localStorage;

  FeedCubit({
    @required this.loadNews,
    @required this.loadPosts,
    @required this.savePost,
    @required this.removePost,
    this.localStorage,
  }) : super(FeedLoading());

  Future<void> load() async {
    try {
      final newsBoticario = await loadNews.load();
      final postsUsers = await loadPosts.load();

      newsBoticario.addAll(postsUsers);

      final sortedResult = newsBoticario
        ..sort(
          (a, b) => b.message.createdAt.compareTo(a.message.createdAt),
        );

      final news = sortedResult.map((post) => toViewModel(post)).toList();

      emit(FeedLoaded(news));
    } catch (error) {
      emit(FeedError(UIError.unexpected.description));
    }
  }

  void logoutUser() async {
    try {
      emit(FeedLoading());
      await localStorage.clear();
      emit(LogoutUser());
    } catch (error) {
      print(error);
    }
  }

  NewsViewModel toViewModel(PostEntity post) {
    return NewsViewModel(
      id: post?.id,
      message: post?.message?.content,
      date: DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_BR')
          .format(post?.message?.createdAt),
      user: post?.user?.name,
      userId: post?.user?.id,
    );
  }
}
