import 'package:flutter/material.dart';
import 'dart:async';

import 'package:login_bloc/src/bloc/bloc.dart';

class BlocProvider extends InheritedWidget {
  final bloc = Bloc();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .bloc;
  }
}
