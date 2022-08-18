import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBordingProvider extends ChangeNotifier {
  var pageIndex = 0;

  void changeIndex(int value) {
    pageIndex = value;
    notifyListeners();
  }
}
