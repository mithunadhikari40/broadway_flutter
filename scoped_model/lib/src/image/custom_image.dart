import 'package:flutter/material.dart';
import 'dart:io';

class CustomImage extends StatelessWidget {
  final List<File> images;

  const CustomImage({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(12.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(width: 2.0),
          ),
          child: Image.file(images[index]),
        );
      },
    );
  }
}
