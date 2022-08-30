import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CartScreenViewModel extends ChangeNotifier {
  late WebViewController controller;

  var isLoadingFinish = false;

  void loadingFinished() {
    isLoadingFinish = true;
    notifyListeners();
  }
}
