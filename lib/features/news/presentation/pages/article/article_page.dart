import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/article/components/article_view.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  static const String name = 'article';
  static const String path = name;

  static final List<BlocProvider> blocProviders = [
    BlocProvider<LocalArticlesBloc>(create: (ctx) => sl<LocalArticlesBloc>()),
  ];

  const ArticlePage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return ArticleView(article: article);
  }
}
