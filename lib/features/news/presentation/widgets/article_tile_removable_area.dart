import 'package:flutter/material.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';

class ArticleTileRemovableArea extends StatelessWidget {
  final Article article;
  final bool isRemovable;
  final void Function(Article) onRemove;

  const ArticleTileRemovableArea({
    super.key,
    required this.article,
    required this.isRemovable,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (!isRemovable) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => onRemove(article),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(Icons.remove_circle_outline, color: Colors.red),
      ),
    );
  }
}
