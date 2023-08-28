import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app_clean_architecture/features/news/presentation/bloc/bloc.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/home/components/home_view.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class HomePage extends StatelessWidget {
  static const String name = '/';
  static const String path = name;

  static final List<BlocProvider> blocProviders = [
    BlocProvider<RemoteArticlesBloc>(create: (ctx) => sl<RemoteArticlesBloc>()),
  ];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
