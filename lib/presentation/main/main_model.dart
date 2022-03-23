import 'package:flutter/material.dart';

enum MainTab {
  gifs,
  favorites,
}

class MainModel extends ChangeNotifier {
  MainTab _mainTab = MainTab.gifs;

  MainTab get mainTab => _mainTab;

  set mainTab(MainTab value) {
    _mainTab = value;
    notifyListeners();
  }
}
