import 'package:flutter/material.dart';

class PostNotifier extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
