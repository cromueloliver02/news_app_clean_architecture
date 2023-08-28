import 'package:flutter/material.dart';

class ArticleContent extends StatelessWidget {
  final String? description;
  final String? content;

  const ArticleContent({
    super.key,
    required this.description,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),
      child: Text(
        '${description ?? ''}\n\n${content ?? ''}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
