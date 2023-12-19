import 'dart:ui';

class AppColors {
  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal();

  static const Color astral = Color(0xFF3279B7);
}
