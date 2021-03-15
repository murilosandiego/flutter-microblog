import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../../application/storage/local_storage.dart';
import '../../../../domain/entities/post_entity.dart';
import '../../../../domain/usecases/load_posts.dart';
import '../../../../domain/usecases/remove_post.dart';
import '../../../../domain/usecases/save_post.dart';
import '../../../helpers/ui_error.dart';
import '../post_viewmodel.dart';
import 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final LoadPosts loadPosts;
  final SavePost savePost;
  final RemovePost removePost;
  final CacheLocalStorage localStorage;

  FeedCubit({
    @required this.loadPosts,
    @required this.savePost,
    @required this.removePost,
    @required this.localStorage,
  }) : super(FeedLoading());

  Future<void> load() async {
    try {
      final postsUsers = await loadPosts.load();

      final news = postsUsers.map((post) => _toViewModel(post)).toList();

      emit(FeedLoaded(news: news));
    } catch (error) {
      emit(FeedError(UIError.unexpected.description));
    }
  }

  NewsViewModel _toViewModel(PostEntity post) {
    return NewsViewModel(
      id: post?.id,
      message: post?.message?.content,
      date: DateFormat(DateFormat.YEAR_MONTH_DAY)
          .format(post?.message?.createdAt),
      user: post?.user?.name,
      userId: post?.user?.id,
    );
  }

  Future<void> handleSavePost(String message) async {
    try {
      final post = await savePost.save(message: message);
      final postViewModel = _toViewModel(post);

      final List<NewsViewModel> updatedPosts =
          List.of((state as FeedLoaded).news)..insert(0, postViewModel);

      emit(FeedLoaded(news: updatedPosts));
    } catch (e) {
      emit(FeedError(UIError.unexpected.description));
    }
  }

  Future<void> logoutUser() async {
    try {
      emit(FeedLoading());
      await localStorage.clear();
      emit(LogoutUser());
    } catch (error) {
      emit(FeedError(UIError.unexpected.description));
    }
  }
}
