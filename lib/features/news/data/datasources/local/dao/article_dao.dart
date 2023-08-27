import 'package:floor/floor.dart';

import 'package:news_app_clean_architecture/features/news/data/models/models.dart';

@dao
abstract class ArticleDao {
  @insert
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('SELECT * FROM tblArticles')
  Future<List<ArticleModel>> getArticles();
}
