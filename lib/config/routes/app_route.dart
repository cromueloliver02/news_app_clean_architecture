import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/pages/pages.dart';

abstract class AppRoute {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: HomePage.name,
        path: HomePage.path,
        builder: (ctx, state) => MultiBlocProvider(
          providers: HomePage.blocProviders,
          child: const HomePage(),
        ),
        routes: [
          GoRoute(
            name: ArticlePage.name,
            path: ArticlePage.path,
            builder: (ctx, state) => MultiBlocProvider(
              providers: ArticlePage.blocProviders,
              child: ArticlePage(article: state.extra as Article),
            ),
          ),
        ],
      ),
    ],
  );
}
