library flutter_canpass_login;

export 'package:flutter_canpass_login/models/can_pass_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/constants.dart';
import 'package:flutter_canpass_login/utls.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_canpass_login/models/can_pass_account.dart';

class FlutterCanPassLogin {
  String _identifier;
  String _secret;
  String _accessToken;

  /// init this in your main.dart
  /// ```
  /// await FlutterCanPassLogin.getInstance().init(
  //     secret: your_secret,
  //     identifier: client_id);
  /// ```
  Future<void> init({String identifier, String secret}) async {
    await Utils.getInstance().init();
    this._identifier = identifier;
    this._secret = secret;
    _accessToken = Utils.getInstance().getAccessTokenFromCache();
  }

  /// return the canpass account object
  ///
  /// ``` final account = await FlutterCanPassLogin.getInstance().logIn(context); ```
  Future<CanPassAccount> logIn(BuildContext context) async {
    try {
      var grant = oauth2.AuthorizationCodeGrant(
          _identifier,
          Uri.parse(Constants.authorizationEndPoint),
          Uri.parse(Constants.tokenEndPoint),
          secret: _secret);
      var authorizationUrl = grant.getAuthorizationUrl(
          Uri.parse(Constants.redirectUrl),
          scopes: ['email']);
      var authorizedUrl =
          await Utils.getInstance().getAuthorizedUri(authorizationUrl, context);
      final _client = await grant
          .handleAuthorizationResponse(authorizedUrl.queryParameters);
      _accessToken = _client.credentials.accessToken;
      Utils.getInstance().saveAccessTokenToCache(_accessToken);
      return getCurrentAccount(_accessToken);
    } catch (e, s) {
      print("logIn() fail $e $s");
      return null;
    }
  }
  /// clear the accesstoken
  ///
  /// ```FlutterCanPassLogin.getInstance().logOut();```
  void logOut() {
    Utils.getInstance().saveAccessTokenToCache('');
  }

  /// return current accesstoken
  ///
  /// ```FlutterCanPassLogin.getInstance().getCurrentToken();```
  String getCurrentToken() {
    return _accessToken;
  }

  /// return current account from given token
  ///
  /// ```FlutterCanPassLogin.getInstance().getCurrentAccount(accesstoken);```
  Future<CanPassAccount> getCurrentAccount(String accessToken) async {
    try {
      final account = await Utils.getInstance().getCanPassAccount(accessToken);
      return account;
    } catch (e, s) {
      print("getCurrentAccount() fail $e $s");
      return null;
    }
  }

  static FlutterCanPassLogin _instance;

  factory FlutterCanPassLogin.getInstance() {
    _instance ??= FlutterCanPassLogin._();
    return _instance;
  }

  FlutterCanPassLogin._();
}
