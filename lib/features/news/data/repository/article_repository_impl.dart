import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/retrofit.dart';

import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/features/news/data/datasources/datasources.dart';
import 'package:news_app_clean_architecture/features/news/data/models/models.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl({
    required NewsApiService newsApiService,
  }) : _newsApiService = newsApiService;

  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    try {
      final String? apiKey = dotenv.env['NEWS_API_KEY'];

      if (apiKey == null) {
        throw Exception(
          'Provide your own .env file and store your API key in NEWS_API_KEY',
        );
      }

      final HttpResponse<ArticlesResponse> httpResponse =
          await _newsApiService.getArticles(
        country: kCountryQuery,
        category: kCategoryQuery,
        apiKey: apiKey,
      );

      if (httpResponse.response.statusCode != HttpStatus.ok) {
        return Left(HttpFailure(
          statusCode: httpResponse.response.statusCode!,
          message: httpResponse.response.statusMessage!,
          stackTrace: StackTrace.current,
        ));
      }

      return Right(httpResponse.data.articles);
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }
}
