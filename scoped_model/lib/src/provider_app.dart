import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model_demo/src/app_provider.dart';

class ProviderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            builder: (_) => AppProvider(),
          ),
        ],
        child: Consumer<AppProvider>(
          builder: (context, provider, _) {
            return MaterialApp(
              theme: provider.getTheme,
              title: "Provider example",
              home: Scaffold(
                appBar: AppBar(
                  title: Text("Provider example"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.theaters),
                      onPressed: () {
                        provider.changeTheme();
                        
                      },
                    )
                  ],
                ),
                body: Center(
                  child: Text(
                      'You have pressed this button this many time ${provider.count}'),
                ),
                floatingActionButton: FloatingActionButtonCustom(),
              ),
            );
          },
        ));
  }
}

class FloatingActionButtonCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppProvider provider = Provider.of(context);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        provider.incrementCount();
      },
    );
  }
}
