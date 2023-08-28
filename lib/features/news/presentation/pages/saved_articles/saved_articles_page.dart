import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/utils/helpers.dart';

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
  void _localArticlesListener(BuildContext ctx, LocalArticlesState state) {
    final bool removing = state.actionType == LocalArticlesActionType.removing;

    if (state.status == LocalArticlesStatus.success && removing) {
      showSnackBar(ctx, message: 'Article removed.');
    }

    if (state.status == LocalArticlesStatus.failure && removing) {
      showSnackBar(ctx, message: 'Something went wrong.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocalArticlesBloc, LocalArticlesState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: _localArticlesListener,
        ),
      ],
      child: const SavedArticlesView(),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<LocalArticlesBloc>().add(LocalArticlesFetched());
  }
}
