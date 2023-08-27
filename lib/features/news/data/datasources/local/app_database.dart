// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:news_app_clean_architecture/features/news/data/datasources/datasources.dart';
import 'package:news_app_clean_architecture/features/news/data/models/models.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
