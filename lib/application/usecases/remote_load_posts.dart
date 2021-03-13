import 'package:meta/meta.dart';

import '../../domain/entities/post_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/load_posts.dart';
import '../http/http_client.dart';
import '../models/post_model.dart';

class RemoteLoadPosts implements LoadPosts {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPosts({@required this.httpClient, @required this.url});

  Future<List<PostEntity>> load() async {
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return (response as List)
          .map((json) => PostModel.fromJsonApiPosts(json))
          .toList()
            ..sort((a, b) => b.id.compareTo(a.id));
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
