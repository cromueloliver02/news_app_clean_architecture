import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/pages.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/saved_articles/components/saved_articles_app_bar.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/widgets.dart';

class SavedArticlesView extends StatefulWidget {
  const SavedArticlesView({super.key});

  @override
  State<SavedArticlesView> createState() => _SavedArticlesViewState();
}

class _SavedArticlesViewState extends State<SavedArticlesView> {
  void _onArticlePressed(Article article) {
    context.pushNamed(ArticlePage.name, extra: article);
  }

  Widget _articlesBuilder(BuildContext ctx, LocalArticlesState state) {
    if (state is LocalArticlesLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (state is LocalArticlesFailure) {
      return const Center(child: Icon(Icons.refresh));
    }

    if (state is LocalArticlesSuccess) {
      return ListView.builder(
        itemCount: state.articles.length,
        itemBuilder: (ctx, idx) => ArticleTile(
          article: state.articles[idx],
          onArticlePressed: _onArticlePressed,
        ),
      );
    }

    return const SizedBox.shrink();
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

  @override
  void initState() {
    super.initState();
    context.read<LocalArticlesBloc>().add(LocalArticlesLoaded());
  }
}
