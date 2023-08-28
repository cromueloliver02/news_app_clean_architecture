import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/saved_articles/components/saved_articles_view.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class SavedArticlesPage extends StatefulWidget {
  static const String name = 'saved-articles';
  static const String path = name;

  static final List<BlocProvider> blocProviders = [
    BlocProvider<LocalArticlesBloc>(create: (ctx) => sl<LocalArticlesBloc>()),
  ];

  const SavedArticlesPage({super.key});

  @override
  State<SavedArticlesPage> createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return const SavedArticlesView();
  }

  @override
  void initState() {
    super.initState();
    context.read<LocalArticlesBloc>().add(LocalArticlesLoaded());
  }
}
