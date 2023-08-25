import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/features/news/data/models/models.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: kNewsApiBaseUrl)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getArticles({
    @Query('country') required String country,
    @Query('category') required String category,
    @Query('apiKey') required String apiKey,
  });
}
