import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier{
  bool isDarkMode = false;

  void UpdateTheme(bool isDarkMode){
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}