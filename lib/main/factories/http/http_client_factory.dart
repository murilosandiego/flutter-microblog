import 'package:boticario_news/main/decorators/authorize_http_client_decorator.dart';
import 'package:boticario_news/main/factories/storage/cache_local_storage_factory.dart';
import 'package:boticario_news/main/factories/usecases/load_current_account_factory.dart';
import 'package:http/http.dart';

import '../../../application/http/http_client.dart';
import '../../../infra/http/http_adapter.dart';

class HttpClientFactory {
  static HttpClient makeHttpClientAdapter() => HttpAdapter(Client());

  static HttpClient makeAuthorizeHttpClientAdapter() =>
      AuthorizeHttpClientDecorator(
        decoratee: HttpAdapter(Client()),
        localStorage: makeLocalStorage(),
        loadCurrentAccount: makeLocalLoadCurrentAccount(),
      );
}
