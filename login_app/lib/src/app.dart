import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Stateful app",
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
