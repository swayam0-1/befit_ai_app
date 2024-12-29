

import 'package:befit_ai_app/controller/secrets/scerets.dart';

import '../models/news_model.dart';

import 'package:http/http.dart' as http;

Future<List<NewsArticle>> fetchHealthNews() async {
  final response = await http.get(Uri.parse(newsApi));

  if (response.statusCode == 200) {
    return parseNewsArticles(response.body);
  } else {
    throw Exception('Failed to load news');
  }
}
