import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/core/usecases/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/repository.dart';

class GetSavedArticlesUseCase
    implements UseCase<Either<Failure, List<Article>>, void> {
  final ArticleRepository _articleRepository;

  const GetSavedArticlesUseCase({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  @override
  Future<Either<Failure, List<Article>>> call(void params) {
    return _articleRepository.getSavedArticles();
  }
}
