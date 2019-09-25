class ImageModel {
  int id;
  String title;
  String url;

  ImageModel(this.id, this.title, this.url);

  ImageModel.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    url = map["url"];
  }

}
