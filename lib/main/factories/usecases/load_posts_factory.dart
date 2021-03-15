import '../../../application/usecases/remote_load_posts.dart';
import '../../../domain/usecases/load_posts.dart';
import '../api_url_factory.dart';
import '../http/http_client_factory.dart';

class LoadPostsFactory {
  static LoadPosts makeRemoteLoadNews() => RemoteLoadPosts(
        httpClient: HttpClientFactory.makeAuthorizeHttpClientAdapter(),
        url: makeApiUrl('news'),
      );
}
