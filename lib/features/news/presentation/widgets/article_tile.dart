import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/presentation/widgets/widgets.dart';

class ArticleTile extends StatelessWidget {
  final Article article;
  final bool isRemovable;
  final void Function(Article article) onRemove;
  final void Function(Article article) onArticlePressed;

  const ArticleTile({
    super.key,
    required this.article,
    required this.onArticlePressed,
    required this.onRemove,
    this.isRemovable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onArticlePressed(article),
      child: Container(
        height: MediaQuery.of(context).size.width / 2.2,
        padding: const EdgeInsetsDirectional.only(
          start: 14,
          end: 14,
          bottom: 7,
          top: 7,
        ),
        child: Row(
          children: [
            ArticleTileImage(imageUrl: article.imageUrl),
            Expanded(
              child: ArticleTileContent(
                title: article.title,
                description: article.description,
                publishedAt: article.publishedAt,
              ),
            ),
            ArticleTileRemovableArea(
              article: article,
              isRemovable: isRemovable,
              onRemove: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
