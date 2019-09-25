import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'dart:async';

class NewsDbProvider {
  NewsDbProvider() {
    init();
  }
  Database db;
  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = Path.join(documentsDirectory.path, 'news.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""

      CREATE TABLE Items 
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
""");
    });
  }

  Future<NewsModel> fetchItem(int id) async {
    final maps = await db.query("Items",
        // columns:["title"],
        columns: null,
        where: "id = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return NewsModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(NewsModel model) async {
    return db.insert('Items', model.toMap());
  }
}
