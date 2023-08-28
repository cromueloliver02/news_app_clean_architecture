import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/home/components/home_app_bar.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/pages.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _onArticlePressed(BuildContext ctx, {required Article article}) {
    ctx.goNamed(ArticlePage.name, extra: article);
  }

  Widget _articlesBuilder(BuildContext ctx, RemoteArticlesState state) {
    final List<RemoteArticlesStatus> initialStatuses = [
      RemoteArticlesStatus.initial,
      RemoteArticlesStatus.loading
    ];

    if (initialStatuses.contains(state.status)) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (state.status == RemoteArticlesStatus.loading) {
      return const Center(child: Icon(Icons.refresh));
    }

    if (state.articles.isEmpty) {
      return const Center(child: Text('No saved news to show'));
    }

    return ListView.builder(
      itemCount: state.articles.length,
      itemBuilder: (ctx, idx) => ArticleTile(
        article: state.articles[idx],
        onArticlePressed: (article) => _onArticlePressed(ctx, article: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      body: BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
        builder: _articlesBuilder,
      ),
    );
  }
}
