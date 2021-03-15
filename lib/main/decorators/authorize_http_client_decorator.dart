import 'package:boticario_news/application/http/http_client.dart';
import 'package:boticario_news/application/http/http_error.dart';
import 'package:boticario_news/application/storage/local_storage.dart';
import 'package:boticario_news/domain/usecases/load_current_account.dart';
import 'package:meta/meta.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final LoadCurrentAccount loadCurrentAccount;
  final HttpClient decoratee;
  final CacheLocalStorage localStorage;

  AuthorizeHttpClientDecorator(
      {@required this.loadCurrentAccount,
      @required this.decoratee,
      @required this.localStorage});

  Future<dynamic> request({
    @required String url,
    @required String method,
    Map body,
    Map headers,
  }) async {
    try {
      final account = await loadCurrentAccount.load();
      final authorizedHeaders = headers ?? {}
        ..addAll({'Authorization': 'Bearer ${account.token}'});

      if (body != null) {
        final bodyUser = {
          "users_permissions_user": {
            "id": "${account.id}",
          }
        };
        body..addAll(bodyUser);
      }

      return await decoratee.request(
          url: url, method: method, body: body, headers: authorizedHeaders);
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        await localStorage.clear();
        throw HttpError.forbidden;
      }
    }
  }
}
