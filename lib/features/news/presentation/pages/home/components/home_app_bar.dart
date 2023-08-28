import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:news_app_clean_architecture/features/news/presentation/pages/pages.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () => context.goNamed(SavedArticlesPage.name),
          icon: const Icon(
            Icons.bookmark,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
