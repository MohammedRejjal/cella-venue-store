import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Cart/cart_screen.dart';
import '../Home/home view/home_view.dart';
import '../categories/category_provider.dart';
import '../categories/category_screen.dart';
import '../home/home_provider.dart';

class BottomNavBarViewModel extends ChangeNotifier {
  var selectedIndex = 1;

  List<Widget> screens = [
    CartScreen(),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, _) => HomeView(),
    ),
    ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
      builder: (context, _) => CategoriesScreen(),
    ),
  ];

  void changeIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}
