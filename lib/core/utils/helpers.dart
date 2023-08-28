import 'package:flutter/material.dart';

void showSnackBar(BuildContext ctx, {required String message}) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(message),
    ),
  );
}
