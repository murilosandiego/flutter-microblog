import '../../../application/usecases/remote_authentication.dart';
import '../../../domain/usecases/authentication.dart';
import '../api_url_factory.dart';
import '../http/http_client_factory.dart';

class AutheticationFactory {
  static Authetication makeRemoteAuthetication() => RemoteAuthentication(
        httpClient: HttpClientFactory.makeHttpClientAdapter(),
        url: makeApiUrl('auth/local'),
      );
}
