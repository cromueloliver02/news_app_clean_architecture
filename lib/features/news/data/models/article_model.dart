import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.imageUrl,
    required super.publishedAt,
    required super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      url: map['url'] ?? '',
      imageUrl: map['urlToImage'],
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'],
    );
  }
}
