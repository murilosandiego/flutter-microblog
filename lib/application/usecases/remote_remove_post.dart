import 'package:meta/meta.dart';

import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/remove_post.dart';
import '../http/http_client.dart';

class RemoteRemovePost implements RemovePost {
  final HttpClient httpClient;
  final String url;

  RemoteRemovePost({@required this.httpClient, @required this.url});

  @override
  Future<void> remove({@required int postId}) async {
    try {
      await httpClient.request(
        url: '$url/$postId',
        method: 'delete',
      );
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
