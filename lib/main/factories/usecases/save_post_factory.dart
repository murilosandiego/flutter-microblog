import '../../../application/usecases/remote_save_post.dart';
import '../../../domain/usecases/save_post.dart';
import '../api_url_factory.dart';
import '../http/http_client_factory.dart';

class SavePostFactory {
  static SavePost makeRemoteSavePost() => RemoteSavePost(
        httpClient: HttpClientFactory.makeAuthorizeHttpClientAdapter(),
        url: makeApiUrl('news'),
      );
}
