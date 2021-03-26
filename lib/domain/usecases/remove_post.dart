import 'package:meta/meta.dart';

abstract class RemovePost {
  Future<bool> remove({@required int postId});
}
