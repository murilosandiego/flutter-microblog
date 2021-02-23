import 'package:http/http.dart';

import '../../../application/http/http_client.dart';
import '../../../infra/http/http_adapter.dart';

class HttpClientFactory {
  static HttpClient makeHttpClientAdapter() => HttpAdapter(Client());
}
