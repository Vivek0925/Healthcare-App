class Article {
  final String id;
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String author;
  final DateTime publishedAt;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      author: json['author'],
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}
