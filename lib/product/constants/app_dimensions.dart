import 'package:flutter/material.dart';

class AppDimensions {
  // Singleton
  static final AppDimensions _instance = AppDimensions._internal();

  factory AppDimensions() {
    return _instance;
  }

  AppDimensions._internal();

  static const EdgeInsets pagePadding = EdgeInsets.all(16.0);

  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(8.0),
  );

  static const double smallGap = 8.0;
  static const double mediumGap = 16.0;
  static const double largeGap = 24.0;
}
