import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:news_app_clean_architecture/features/news/data/datasources/datasources.dart';
import 'package:news_app_clean_architecture/features/news/data/datasources/local/app_database.dart';
import 'package:news_app_clean_architecture/features/news/data/repository/repository.dart';
import 'package:news_app_clean_architecture/features/news/domain/repository/repository.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/usecases.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';

final GetIt sl = GetIt.instance;

void setup() {
  // external dependencies
  sl.registerSingletonAsync<AppDatabase>(() async {
    final AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database;
  });
  sl.registerSingleton<Dio>(Dio());

  // data sources
  sl.registerSingleton<NewsApiService>(NewsApiService(sl<Dio>()));

  // repositories
  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(
      newsApiService: sl<NewsApiService>(),
      appDatabase: sl<AppDatabase>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetArticlesUseCase>(
    GetArticlesUseCase(articleRepository: sl<ArticleRepository>()),
  );
  sl.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(articleRepository: sl<ArticleRepository>()),
  );
  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(articleRepository: sl<ArticleRepository>()),
  );
  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(articleRepository: sl<ArticleRepository>()),
  );

  // blocs
  sl.registerFactory<ArticlesBloc>(
    () => ArticlesBloc(sl<GetArticlesUseCase>()),
  );
}
