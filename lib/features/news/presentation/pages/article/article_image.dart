import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  final String imageUrl;

  const ArticleImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(imageUrl, fit: BoxFit.cover),
    );
  }
}
