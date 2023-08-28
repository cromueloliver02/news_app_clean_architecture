import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/pages.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/saved_articles/components/saved_articles_app_bar.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/widgets.dart';

class SavedArticlesView extends StatelessWidget {
  const SavedArticlesView({super.key});

  void _onArticlePressed(BuildContext ctx, {required Article article}) {
    ctx.pushNamed(ArticlePage.name, extra: article);
  }

  void _onRemove(BuildContext ctx, {required Article article}) {
    ctx.read<LocalArticlesBloc>().add(LocalArticlesRemoved(article: article));
  }

  Widget _articlesBuilder(BuildContext ctx, LocalArticlesState state) {
    final List<LocalArticlesStatus> initialStatuses = [
      LocalArticlesStatus.initial,
      LocalArticlesStatus.loading
    ];

    if (initialStatuses.contains(state.status)) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (state.status == LocalArticlesStatus.failure) {
      return const Center(child: Icon(Icons.refresh));
    }

    return ListView.builder(
      itemCount: state.articles.length,
      itemBuilder: (ctx, idx) => ArticleTile(
        article: state.articles[idx],
        onArticlePressed: (article) => _onArticlePressed(ctx, article: article),
        onRemove: (article) => _onRemove(ctx, article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SavedArticlesAppBar(),
      ),
      body: BlocBuilder<LocalArticlesBloc, LocalArticlesState>(
        builder: _articlesBuilder,
      ),
    );
  }
}
