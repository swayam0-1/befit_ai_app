import 'dart:convert';

class NewsArticle {
  final String title;
  final String? description; // Nullable
  final String? urlToImage; // Nullable
  final String publishedAt;

  NewsArticle({
    required this.title,
    this.description,
    this.urlToImage,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '', // Default to an empty string
    );
  }
}

List<NewsArticle> parseNewsArticles(String responseBody) {
  final parsed = json.decode(responseBody)['articles'].cast<Map<String, dynamic>>();
  return parsed.map<NewsArticle>((json) => NewsArticle.fromJson(json)).toList();
}
