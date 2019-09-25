class ItemModel{
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
 final int descendants;


 ItemModel.fromJson(Map<String,dynamic> map):
    id=map["id"],
    deleted=map["deleted"],
    type=map["type"],
    by=map["by"],
    time=map["time"],
    text=map["text"],
    dead=map["dead"],
    parent=map["parent"],
    kids=map["kids"],
    url=map["url"],
    score=map["score"],
    title=map["title"],
    descendants=map["descendants"]; 

 

}