import '../../../application/usecases/remote_remove_post.dart';
import '../../../domain/usecases/remove_post.dart';
import '../api_url_factory.dart';
import '../http/http_client_factory.dart';

class RemovePostFactory {
  static RemovePost makeRemoteRemovePost() => RemoteRemovePost(
        httpClient: HttpClientFactory.makeAuthorizeHttpClientAdapter(),
        url: makeApiUrl('news'),
      );
}
