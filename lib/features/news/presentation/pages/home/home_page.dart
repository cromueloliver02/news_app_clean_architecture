import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _articlesBuilder(BuildContext ctx, RemoteArticlesState state) {
    return switch (state) {
      RemoteArticlesLoading() =>
        const Center(child: CupertinoActivityIndicator()),
      RemoteArticlesFailure() => const Center(child: Icon(Icons.refresh)),
      RemoteArticlesSuccess() => ListView.builder(
          itemCount: state.articles.length,
          itemBuilder: (ctx, idx) => ArticleTile(
            article: state.articles[idx],
            onArticlePressed: (Article article) {},
            onRemove: (Article article) {},
          ),
        ),
    };
  }

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
          builder: _articlesBuilder),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<RemoteArticlesBloc>().add(RemoteArticlesLoaded());
  }
}
