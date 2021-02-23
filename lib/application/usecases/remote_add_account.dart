import 'package:meta/meta.dart' show required;

import '../../domain/entities/account_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/usecases/add_account.dart';
import '../http/http_client.dart';
import '../http/http_error.dart';
import '../models/account_model.dart';

class RemoteAddAccount implements AddAccount {
  final HttpClient httpClient;
  final String url;

  RemoteAddAccount({
    @required this.httpClient,
    @required this.url,
  });

  @override
  Future<AccountEntity> add(AddAccountParams params) async {
    final body = RemoteAddAccountParams.fromDomain(params).toJson();

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

class RemoteAddAccountParams {
  final String name;
  final String email;
  final String password;

  RemoteAddAccountParams(
      {@required this.email, @required this.password, @required this.name});

  factory RemoteAddAccountParams.fromDomain(AddAccountParams params) =>
      RemoteAddAccountParams(
          email: params.email, password: params.secret, name: params.name);

  Map toJson() => {
        'username': name,
        'email': email,
        'password': password,
      };
}
