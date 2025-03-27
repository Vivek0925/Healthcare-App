import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ArticleService {
  static const String apiKey = '7fc88170f7ca4d5aae1ea42556389909'; // Replace with your API key
  static const String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> getHealthArticles() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/everything?q=health&language=en&sortBy=publishedAt&apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List;

        return articles
            .map((article) => Article.fromJson({
                  'id': article['url'],
                  'title': article['title'],
                  'description': article['description'] ?? '',
                  'content': article['content'] ?? '',
                  'imageUrl': article['urlToImage'] ??
                      'https://via.placeholder.com/300',
                  'author': article['author'] ?? 'Unknown',
                  'publishedAt': article['publishedAt'],
                }))
            .toList();
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }
}
