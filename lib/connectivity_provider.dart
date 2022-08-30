import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider with ChangeNotifier {
  Connectivity _connectivity = new Connectivity();

  bool? isOnline;

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((
      ConnectivityResult result,
    ) async {
      if (result == ConnectivityResult.none) {
        isOnline = false;
        notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        isOnline = false;
        notifyListeners();
      } else {
        isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print("PlatformException: " + e.toString());
    }
  }

  Future<bool> _updateConnectionStatus() async {
    late bool isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      //return false;
    }
    return isConnected;
  }
}
