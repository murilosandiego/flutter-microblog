import '../../../application/usecases/remote_load_news.dart';
import '../../../domain/usecases/load_news.dart';
import '../api_url_factory.dart';
import '../http/http_client_factory.dart';

class LoadNewsFactory {
  static LoadNews makeRemoteLoadNews() => RemoteLoadNews(
        httpClient: HttpClientFactory.makeHttpClientAdapter(),
        url: makeApiNews(),
      );
}
