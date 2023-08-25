import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getArticles();
}
