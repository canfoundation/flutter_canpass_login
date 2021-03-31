import 'package:flutter/material.dart';
import 'package:flutter_canpass_login/flutter_canpass_login.dart';
import 'package:canpass_login_example/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterCanPassLogin.getInstance().init(secret: 'f5e7cdda11283d7adc563d2ed6bd1f37811449e84325d61031edcb11a5ff447a', identifier: 'd63711dcdf13608609a7e82ea0c2cb7a');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Canpass login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

