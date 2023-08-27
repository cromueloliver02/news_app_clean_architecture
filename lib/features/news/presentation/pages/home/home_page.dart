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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily News',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (ctx, state) {
          if (state is ArticlesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state is ArticlesFailure) {
            return const Center(child: Icon(Icons.refresh));
          }

          state = state as ArticlesSuccess;

          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (ctx, idx) => ArticleTile(
              article: (state as ArticlesSuccess).articles[idx],
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
    context.read<ArticlesBloc>().add(ArticlesLoaded());
  }
}
