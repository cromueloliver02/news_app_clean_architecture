import 'package:news_app_clean_architecture/features/news/data/models/models.dart';

class ArticlesResponse {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  const ArticlesResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticlesResponse.fromJson(Map<String, dynamic> map) {
    final List<ArticleModel> articles = List<ArticleModel>.from(
      map['articles']?.map((d) => ArticleModel.fromJson(d)),
    );

    return ArticlesResponse(
      status: map['status'] ?? '',
      totalResults: map['totalResults']?.toInt() ?? 0,
      articles: articles,
    );
  }
}
