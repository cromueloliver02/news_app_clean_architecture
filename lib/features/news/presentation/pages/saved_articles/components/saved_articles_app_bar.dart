import 'package:flutter/material.dart';

class SavedArticlesAppBar extends StatelessWidget {
  const SavedArticlesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Saved Articles',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
