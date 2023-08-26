import 'package:news_app_clean_architecture/features/news/data/models/models.dart';

// TODO: add more properties
class ArticlesResponse {
  final List<ArticleModel> articles;

  const ArticlesResponse({
    required this.articles,
  });

  factory ArticlesResponse.fromJson(Map<String, dynamic> map) {
    final List<ArticleModel> articles = List<ArticleModel>.from(
      map['articles']?.map((d) => ArticleModel.fromJson(d)),
    );

    return ArticlesResponse(articles: articles);
  }
}
