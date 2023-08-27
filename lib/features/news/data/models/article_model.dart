import 'package:floor/floor.dart';

import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';

@Entity(tableName: 'tblArticles', primaryKeys: ['id'])
class ArticleModel extends Article {
  const ArticleModel({
    required super.id,
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
      id: map['id']?.toInt() ?? 0,
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      url: map['url'] ?? '',
      imageUrl: map['urlToImage'] ?? kDefaultArticleImage,
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'],
    );
  }
}
