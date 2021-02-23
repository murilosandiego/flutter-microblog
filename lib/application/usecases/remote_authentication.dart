import 'package:meta/meta.dart' show required;

import '../../domain/entities/account_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/authentication.dart';
import '../http/http_client.dart';
import '../http/http_error.dart';
import '../models/account_model.dart';

class RemoteAuthentication implements Authetication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();

    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);
      return AccountModel.fromJson(httpResponse);
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({
    @required this.email,
    @required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'identifier': email, 'password': password};
}
