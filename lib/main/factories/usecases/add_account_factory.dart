import '../../../application/usecases/remote_add_account.dart';
import '../../../domain/usecases/add_account.dart';
import '../api_url_factory.dart';
import '../http/http_client_factory.dart';

class AddAccountFactory {
  static AddAccount makeRemoteAddAccount() => RemoteAddAccount(
        httpClient: HttpClientFactory.makeHttpClientAdapter(),
        url: makeApiUrl('auth/local/register'),
      );
}
