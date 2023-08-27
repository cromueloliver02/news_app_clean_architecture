import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';

abstract class ArticleRepository {
  // API methods
  Future<Either<Failure, List<Article>>> getArticles();

  // Local database methods
  Future<Either<Failure, List<Article>>> getSavedArticles();

  Future<Either<Failure, void>> saveArticle(Article article);

  Future<Either<Failure, void>> removeArticle(Article article);
}
