import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.grey,
    ),
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(),
    errorBorder: OutlineInputBorder(),
    focusedErrorBorder: OutlineInputBorder(),
  ),
);
