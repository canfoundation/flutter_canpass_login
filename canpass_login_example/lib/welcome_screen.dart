import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/flutter_canpass_login.dart';
import 'package:flutter_canpass_login/models/can_pass_account.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  Future.delayed(Duration(milliseconds: 1500), () {
    initAuth();
  });
  }

  void initAuth() async {
    String accessToken = FlutterCanPassLogin.getInstance().getCurrentToken();
    CanPassAccount account;
    if (accessToken != null && accessToken.isNotEmpty) {
      account = await FlutterCanPassLogin.getInstance()
          .getCurrentAccount(accessToken);
      if(account != null) {
        _gotoHomeScreen(account);
      } else {
        _gotoLoginScreen();
      }
    } else {
      _gotoLoginScreen();
    }
  }

  void _gotoHomeScreen(CanPassAccount account) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen(account: account,)));
  }

  void _gotoLoginScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Welcome Screen"),
            SizedBox(height: 10,),
            CircularProgressIndicator()
          ],
        )),
      ),
    );
  }
}
