import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/constants.dart';
import 'package:flutter_canpass_login/models/can_pass_account.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Utils {
  SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<CanPassAccount> getCanPassAccount(String accessToken) async {
    final HttpLink httpLink = HttpLink(
      Constants.graphQL
    );
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
    ))).data['me'];
    return CanPassAccount.fromJson(accountMap);
  }

  Future<Uri> getAuthorizedUri(Uri authorizationUrl, BuildContext context) async {
    final authorizedUri = await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: authorizationUrl.toString(),
        navigationDelegate: (navReq) {
          if (navReq.url.startsWith(Constants.redirectUrl.toString())) {
            var responseUrl = Uri.parse(navReq.url);
            Navigator.of(context).pop(responseUrl);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      );
    }));
    return authorizedUri;
  }

  void saveAccessTokenToCache(String accessToken) {
    _prefs.setString(Constants.canPassAccessTokenRef, accessToken);
  }

  String getAccessTokenFromCache() {
    return _prefs.getString(Constants.canPassAccessTokenRef);
  }

  static Utils _instance;
  factory Utils.getInstance() {
    _instance ??= Utils._();
    return _instance;
  }
  Utils._();
}