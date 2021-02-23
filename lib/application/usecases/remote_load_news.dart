import 'package:meta/meta.dart' show required;

import '../../domain/entities/post_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/load_news.dart';
import '../http/http_client.dart';
import '../models/post_model.dart';

class RemoteLoadNews implements LoadNews {
  final HttpClient httpClient;
  final String url;

  RemoteLoadNews({@required this.httpClient, @required this.url});

  Future<List<PostEntity>> load() async {
    try {
      final response = await httpClient.request(url: url, method: 'get');
      return (response['news'] as List)
          .map((json) => PostModel.fromJson(json))
          .toList();
    } catch (_) {
      throw DomainError.unexpected;
    }
  }
}
