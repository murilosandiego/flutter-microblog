import '../entities/post_entity.dart';

abstract class LoadPosts {
  Future<List<PostEntity>> load();
}
