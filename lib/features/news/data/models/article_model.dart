import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';

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
    const Uuid uuid = Uuid();

    return ArticleModel(
      id: uuid.v4(),
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      url: map['url'] ?? '',
      imageUrl: map['urlToImage'] ?? kDefaultArticleImage,
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'],
    );
  }

  factory ArticleModel.fromEntity(Article article) {
    return ArticleModel(
      id: article.id,
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      imageUrl: article.imageUrl,
      publishedAt: article.publishedAt,
      content: article.content,
    );
  }
}
