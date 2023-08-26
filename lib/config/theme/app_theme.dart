import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Muli',
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
      titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}
