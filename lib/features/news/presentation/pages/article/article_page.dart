import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/core/utils/helpers.dart';
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

  void _localArticlesListener(BuildContext ctx, LocalArticlesState state) {
    final bool saving = state.actionType == LocalArticlesActionType.saving;

    if (state.status == LocalArticlesStatus.success && saving) {
      showSnackBar(ctx, message: 'Article saved successfully.');
    }

    if (state.status == LocalArticlesStatus.failure && saving) {
      showSnackBar(ctx, message: 'Something went wrong.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocalArticlesBloc, LocalArticlesState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: _localArticlesListener,
        ),
      ],
      child: ArticleView(article: article),
    );
  }
}
