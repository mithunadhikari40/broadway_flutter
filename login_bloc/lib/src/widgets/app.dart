import 'package:flutter/material.dart';
import 'package:login_bloc/src/bloc/bloc_provider.dart';

import 'login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Login app bloc',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
