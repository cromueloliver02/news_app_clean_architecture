import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ArticleAppBar extends StatelessWidget {
  const ArticleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: const Icon(Ionicons.chevron_back, color: Colors.black),
      ),
    );
  }
}
