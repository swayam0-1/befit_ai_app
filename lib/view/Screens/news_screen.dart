import 'package:befit_ai_app/controller/news_controller.dart';
import 'package:befit_ai_app/models/news_model.dart';
import 'package:flutter/material.dart';

// Adjust the import path

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health News'),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: fetchHealthNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description ?? 'No description available'),
                  leading: article.urlToImage != null && article.urlToImage!.isNotEmpty
                      ? Image.network(article.urlToImage!, width: 50, height: 50, fit: BoxFit.cover)
                      : null,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ArticleDetailScreen(article: article)),
                    // );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
