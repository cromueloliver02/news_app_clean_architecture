import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:news_app_clean_architecture/injection_container.dart' as di;
import 'package:news_app_clean_architecture/news_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  di.setup();

  runApp(const NewsApp());
}
