import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:scoped_model_demo/src/image/custom_image.dart';
import 'package:image_picker/image_picker.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final List<File> pickedImages = [];

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
        title: "Camera example ",
        home: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Image picker example"),
              ),
              body: CustomImage(
                images: pickedImages,
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  _pickImageDialog(context);
                },
              ),
            );
          },
        ));
  }

  void _pickImage(ImageSource source) async {
    File imageFile = await ImagePicker.pickImage(source: source);
    setState(() {
      pickedImages.add(imageFile);
    });
  }

  void _pickImageDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("How would you like to pick the image?"),
            Container(
              height: 50,
              width: double.infinity,
              child: RaisedButton(
                child: const Text("From gallery"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                child: const Text("From camera"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
