//1. create a class and import the flutter standard library
//2. extend StatelessWidget base class
//3 . override the build method
//4. return the widget that this widget is intending to return
import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:pics/src/widgets/image_list.dart';
import 'dart:convert' show jsonDecode;

import 'models/image_model.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int count = 0;
  List<ImageModel> images = [];

  void fetchImages() async {
    count++;
    var response =
        await get('https://jsonplaceholder.typicode.com/photos/$count');
    print(response.body);
    var data = jsonDecode(response.body);
    ImageModel imageModel = ImageModel.fromJson(data);
    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image app"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImages,
          child: Icon(
            Icons.add,
            size: 24,
          ),
        ),
        body: ImageList(images),
      ),
    );
  }
}
