import 'package:cell_avenue_store/connectivity_provider.dart';
import 'package:cell_avenue_store/noConnection.dart';
import 'package:cell_avenue_store/ui/Cart/cart_screen_view_model.dart';
import 'package:cell_avenue_store/ui/categories/categories_provider.dart';
import 'package:cell_avenue_store/ui/categories/category_without_image.dart';
import 'package:cell_avenue_store/ui/categories/slide_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Cart/cart_screen.dart';
import '../Home/home view/home_view.dart';
import '../home/home_provider.dart';
import 'package:cell_avenue_store/main.dart' as m;

class BottomNavBarViewModel extends ChangeNotifier {
  var selectedIndex = 1;

  List<Widget> screens = [
    ChangeNotifierProvider(
      create: (context) => CartScreenViewModel(),
      builder: (context, _) => CartScreen(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, _) => HomeView(),
    ),
    // ChangeNotifierProvider(
    //   create: (context) => CategoryProductsProvider(),
    //   builder: (context, _) => CategoryWithoutImage(),
    // ),

    SlideCategories(),
  ];

  void changeIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}
