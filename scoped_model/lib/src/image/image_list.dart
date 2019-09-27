import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:scoped_model_demo/src/image/custom_image.dart';

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

    uploadImage(imageFile);
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

  void uploadImage(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile('userImage', stream, length,
        filename: basename(imageFile.path));

    // string to uri
    var uri = Uri.parse(
        "http://192.168.101.213:8001/UNDP.RIMS_API/public/saveDemoData");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    

    // add file to multipart
    request.files.add(multipartFile);
    request.fields["username"] = "someone@example.com";

    // send
    var response = await request.send();
    print("The response from the server is $response");

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
