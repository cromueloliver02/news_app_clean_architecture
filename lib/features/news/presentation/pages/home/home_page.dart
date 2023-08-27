import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/article_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily News',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
        builder: (ctx, state) {
          if (state is RemoteArticlesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state is RemoteArticlesFailure) {
            return const Center(child: Icon(Icons.refresh));
          }

          state = state as RemoteArticlesSuccess;

          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (ctx, idx) => ArticleTile(
              article: (state as RemoteArticlesSuccess).articles[idx],
              onArticlePressed: (Article article) {},
              onRemove: (Article article) {},
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<RemoteArticlesBloc>().add(ArticlesFetched());
  }
}
