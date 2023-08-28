import 'package:flutter/material.dart';

import 'package:news_app_clean_architecture/config/config.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MaterialApp.router(
          title: 'News App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          routerConfig: AppRoute.router,
        );
      },
    );
  }
}
