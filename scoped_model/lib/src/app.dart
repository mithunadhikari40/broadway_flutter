import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_demo/src/app_model.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) {
          return MaterialApp(
            theme: model.getTheme,
            title: 'Scoped model example',
            home: Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.theaters),
                      onPressed: () {
                        model.changeTheme();
                        model.getBatteryLevel();
                        
                      })
                ],
                title: Text("Scoped model demo"),
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                        'You have pressed this button this many time ${model.count}'),
                        Text(
                        'Your battery level is ${model.batteryLevel}'),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  model.incrementCount();
                },
                child: Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
