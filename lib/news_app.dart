import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/config/theme/app_theme.dart';
import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/pages.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Center(child: CircularProgressIndicator()),
          );
        }

        return MaterialApp(
          title: 'News App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: BlocProvider<RemoteArticlesBloc>(
            create: (ctx) => sl<RemoteArticlesBloc>(),
            child: const HomePage(),
          ),
        );
      },
    );
  }
}
