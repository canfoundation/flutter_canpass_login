import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/constants.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginWebView extends StatefulWidget {
  final Uri authorizationUrl;

  const LoginWebView({Key key, this.authorizationUrl}) : super(key: key);
  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  FlutterWebviewPlugin webView;
  bool isPopped = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:() async {
      webView.close();
      Navigator.pop(context);
      return false;
    },child: Scaffold(body: Container(color: Colors.transparent,)));
  }

  @override
  void initState() {
    super.initState();
    webView = FlutterWebviewPlugin();
    webView.launch(widget.authorizationUrl.toString(), clearCookies: true, clearCache: true);
    webView.onBack.listen((e) {
      webView.close();
      Navigator.pop(context);
    });
    webView.onStateChanged.listen((event) {
      if (event.url.startsWith(Constants.redirectUrl.toString())) {
        if(isPopped) return;
        isPopped = true;
        var responseUrl = Uri.parse(event.url);
        webView.close();
        Navigator.of(context).pop(responseUrl);
      }
    });
  }
}
