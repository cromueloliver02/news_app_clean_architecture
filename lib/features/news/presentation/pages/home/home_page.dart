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
  Widget _articlesBuilder(BuildContext ctx, ArticlesState state) {
    return switch (state) {
      ArticlesLoading() => const Center(child: CupertinoActivityIndicator()),
      ArticlesFailure() => const Center(child: Icon(Icons.refresh)),
      ArticlesSuccess() => ListView.builder(
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
      body: BlocBuilder<ArticlesBloc, ArticlesState>(builder: _articlesBuilder),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ArticlesBloc>().add(ArticlesLoaded());
  }
}
