import 'package:meta/meta.dart';

abstract class RemovePost {
  Future<void> remove({@required int postId});
}
