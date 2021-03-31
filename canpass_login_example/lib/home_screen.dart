import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/flutter_canpass_login.dart';
import 'package:flutter_canpass_login/models/can_pass_account.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final CanPassAccount account;

  const HomeScreen({Key key, this.account}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _logOut() {
    FlutterCanPassLogin.getInstance().logOut();
    _gotoLoginScreen();
  }

  void _gotoLoginScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),), body: Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("email is ${widget.account.email}"),
            ElevatedButton(onPressed: _logOut, child: Text("LogOut"),)
          ],
        ),
      ),
    ),
    );
  }
}
