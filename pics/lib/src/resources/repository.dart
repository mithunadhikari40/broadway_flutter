import 'dart:async';
import 'package:news/src/models/news_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopStories();
  }

  Future<NewsModel> fetchItem(int id) async {
    var data = await dbProvider.fetchItem(id);
    if (data != null) {
      return data;
    }
    data = await apiProvider.fetchItem(id);
    dbProvider.addItem(data);

    return data;
  }
}
