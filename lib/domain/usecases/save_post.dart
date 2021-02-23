import 'package:meta/meta.dart';

import '../entities/post_entity.dart';

abstract class SavePost {
  Future<PostEntity> save({@required String message, int postId});
}
