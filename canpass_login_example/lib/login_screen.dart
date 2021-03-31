import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/flutter_canpass_login.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String err = '';

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    final account = await FlutterCanPassLogin.getInstance().logIn(context);
    setState(() {
      _isLoading = false;
    });
    if(account != null) {
      _gotoHomeScreen(account);
    } else {
      setState(() {
        err = 'pls try again';
      });
    }
  }

  void _gotoHomeScreen(CanPassAccount account) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen(account: account,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen"),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: _login, child: Text("Login with canpass"),),
              SizedBox(height: 10,),
              Text(err, style: TextStyle(color: Colors.red),),
              SizedBox(height: 10,),
              if(_isLoading) CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
