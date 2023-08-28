import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/saved_articles/components/saved_articles_view.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class SavedArticlesPage extends StatelessWidget {
  static const String name = 'saved-articles';
  static const String path = name;

  static final List<BlocProvider> blocProviders = [
    BlocProvider<LocalArticlesBloc>(create: (ctx) => sl<LocalArticlesBloc>()),
  ];

  const SavedArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SavedArticlesView();
  }
}
