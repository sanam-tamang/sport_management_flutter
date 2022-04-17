import 'package:flutter/material.dart';

class SmallValueChangerProvider extends ChangeNotifier {
  int _homeIndex = 0;
  int get homeIndex => _homeIndex;
  void changeHomeIndex(int index) {
    _homeIndex = index;
    notifyListeners();
  }

  /*****Visibility true or false changer */

  bool _isVisible = false;
  bool get isVisible => _isVisible;
  void changeVisibility() {
    _isVisible = !isVisible;
    notifyListeners();
  }
}
