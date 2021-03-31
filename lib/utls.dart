import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/constants.dart';
import 'package:flutter_canpass_login/models/can_pass_account.dart';
import 'package:flutter_canpass_login/webview.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Utils {
  Future<void> init() async {
    await GetStorage.init();
  }

  Future<CanPassAccount> getCanPassAccount(String accessToken) async {
    final HttpLink httpLink = HttpLink(Constants.graphQL);
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $accessToken',
    );
    final Link link = authLink.concat(httpLink);

    final accountMap = (await GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    ).query(QueryOptions(
      document: gql(Constants.readAccountQuery),
      variables: {
        'nRepositories': 50,
      },
      pollInterval: Duration(seconds: 10),
    )))
        .data['me'];
    return CanPassAccount.fromJson(accountMap);
  }

  Future<Uri> getAuthorizedUri(Uri authorizationUrl, BuildContext context) async {
    final authorizedUrl = await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return LoginWebView(authorizationUrl: authorizationUrl,);
    }));
    return authorizedUrl;
  }

  void saveAccessTokenToCache(String accessToken) {
    GetStorage().write(Constants.canPassAccessTokenRef, accessToken);
  }

  String getAccessTokenFromCache() {
    return GetStorage().read<String>(Constants.canPassAccessTokenRef);
  }

  static Utils _instance;

  factory Utils.getInstance() {
    _instance ??= Utils._();
    return _instance;
  }

  Utils._();
}
