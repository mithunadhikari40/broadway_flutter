import 'package:pics/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('Sample testing', () {
//setup of test case
//to run the test run fltuter test
    final sum = 2 + 2;
    expect(sum, 4);

//expectation of the output
  });

  test('Fetch top ids return a list of ids', () async {
//setup of test case
//to run the test run fltuter test
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      var jsonList = json.encode([1, 2, 3, 400]);
      return Response(jsonList, 200);
    });
    final ids = await newsApi.fetchTopIds();
    expect(ids, [1, 2, 3, 400]);
  });

  test('Fetch item returns the ItemModel', () async {
//setup of test case
//to run the test run fltuter test
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      var data = {'id': 123};
      var jsonList = json.encode(data);
      return Response(jsonList, 200);
    });
    final item = await newsApi.fetchItem(32);
    expect(item.id, 123);

//expectation of the output
  });
}
