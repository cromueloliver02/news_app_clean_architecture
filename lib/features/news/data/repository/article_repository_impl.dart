import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/features/news/data/models/models.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles() {
    throw UnimplementedError();
  }
}
