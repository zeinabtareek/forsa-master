import 'package:flutter/material.dart';

class PageIndexController with ChangeNotifier {
  int index = 0;

  void changeIndexFunction(int index) {
    this.index = index;
    notifyListeners();
  }

  void changeIndexFunctionWithOutNotify(int index) {
    this.index = index;
  }
}
