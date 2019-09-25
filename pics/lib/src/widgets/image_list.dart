import 'package:flutter/material.dart';
import 'package:pics/src/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  ImageList(this.images);

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
          child: Column(
            children: <Widget>[
              Image.network(images[index].url),
              Padding(
                child: Text(images[index].title),
                padding: EdgeInsets.only(top: 12.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
