import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/core/usecases/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/repository.dart';

class SaveArticleUseCase implements UseCase<void, Article> {
  final ArticleRepository _articleRepository;

  const SaveArticleUseCase({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  @override
  Future<Either<Failure, void>> call(Article params) {
    return _articleRepository.saveArticle(params);
  }
}
