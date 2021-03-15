import 'package:meta/meta.dart';

import '../../domain/entities/post_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/save_post.dart';
import '../http/http_client.dart';
import '../models/post_model.dart';

class RemoteSavePost implements SavePost {
  final HttpClient httpClient;
  final String url;

  RemoteSavePost({
    @required this.httpClient,
    @required this.url,
  });

  @override
  Future<PostEntity> save({@required String message, int postId}) async {
    final body = {
      "message": {"content": message},
    };
    try {
      final httpResponse = await httpClient.request(
        url: postId == null ? url : '$url/$postId',
        method: postId == null ? 'post' : 'put',
        body: body,
      );

      return PostModel.fromJsonApiPosts(httpResponse);
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
