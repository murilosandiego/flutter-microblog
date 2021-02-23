import '../entities/post_entity.dart';

abstract class LoadNews {
  Future<List<PostEntity>> load();
}
