import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:pics/src/resources/news_model.dart';


const url = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();
  Future<List<int>> fetchTopStories() async {
    final response = await client.get("$url/topstories.json");
    final data = jsonDecode(response.body);
    return data.cast<int>();
  }

  Future<NewsModel> fetchItem(int id) async {
    final response = await client.get("$url/item/$id.json");
    final data = jsonDecode(response.body);
    final NewsModel model = NewsModel.fromJson(data);
    return model;
  }
}
