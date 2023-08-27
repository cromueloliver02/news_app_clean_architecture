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
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingletonAsync<AppDatabase>(() async {
    final AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database;
  });

  // data sources
  sl.registerSingleton<NewsApiService>(NewsApiService(sl<Dio>()));

  // repositories
  sl.registerSingletonWithDependencies<ArticleRepository>(
    () => ArticleRepositoryImpl(
      newsApiService: sl<NewsApiService>(),
      appDatabase: sl<AppDatabase>(),
    ),
    dependsOn: [AppDatabase],
  );

  // use cases
  sl.registerSingletonWithDependencies<GetArticlesUseCase>(
    () => GetArticlesUseCase(articleRepository: sl<ArticleRepository>()),
    dependsOn: [ArticleRepository],
  );
  sl.registerSingletonWithDependencies<GetSavedArticlesUseCase>(
    () => GetSavedArticlesUseCase(articleRepository: sl<ArticleRepository>()),
    dependsOn: [ArticleRepository],
  );
  sl.registerSingletonWithDependencies<SaveArticleUseCase>(
    () => SaveArticleUseCase(articleRepository: sl<ArticleRepository>()),
    dependsOn: [ArticleRepository],
  );
  sl.registerSingletonWithDependencies<RemoveArticleUseCase>(
    () => RemoveArticleUseCase(articleRepository: sl<ArticleRepository>()),
    dependsOn: [ArticleRepository],
  );

  // blocs
  sl.registerFactory<ArticlesBloc>(
    () => ArticlesBloc(sl<GetArticlesUseCase>()),
  );
  sl.registerFactory<LocalArticlesBloc>(
    () => LocalArticlesBloc(
      getSavedArticlesUseCase: sl<GetSavedArticlesUseCase>(),
    ),
  );
}
