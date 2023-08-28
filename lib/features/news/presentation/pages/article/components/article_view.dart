import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/article/components/ariticle_header.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/article/components/article_app_bar.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/article/components/article_content.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/article/components/article_image.dart';

class ArticleView extends StatelessWidget {
  final Article article;

  const ArticleView({
    super.key,
    required this.article,
  });

  void _onFloatingActionButtonPressed(BuildContext ctx) {
    ctx.read<LocalArticlesBloc>().add(LocalArticlesSaved(article: article));

    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ArticleAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ArticleHeader(
              title: article.title,
              publishedAt: article.publishedAt,
            ),
            ArticleImage(imageUrl: article.imageUrl),
            ArticleContent(
              description: article.description,
              content: article.content,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Ionicons.bookmark, color: Colors.white),
      ),
    );
  }
}
