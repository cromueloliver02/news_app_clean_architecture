import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/home/components/home_app_bar.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/pages.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _onArticlePressed(Article article) {
    context.goNamed(ArticlePage.name, extra: article);
  }

  Widget _articlesBuilder(BuildContext ctx, RemoteArticlesState state) {
    return switch (state) {
      RemoteArticlesLoading() =>
        const Center(child: CupertinoActivityIndicator()),
      RemoteArticlesFailure() => const Center(child: Icon(Icons.refresh)),
      RemoteArticlesSuccess() => ListView.builder(
          itemCount: state.articles.length,
          itemBuilder: (ctx, idx) => ArticleTile(
            article: state.articles[idx],
            onArticlePressed: _onArticlePressed,
          ),
        ),
    };
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

  @override
  void initState() {
    super.initState();
    context.read<RemoteArticlesBloc>().add(RemoteArticlesLoaded());
  }
}
