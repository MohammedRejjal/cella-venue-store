import 'package:cell_avenue_store/ui/categories/categories_provider.dart';
import 'package:cell_avenue_store/ui/categories/category_without_image.dart';
import 'package:cell_avenue_store/ui/categories/slide_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Cart/cart_screen.dart';
import '../Home/home view/home_view.dart';
import '../home/home_provider.dart';

class BottomNavBarViewModel extends ChangeNotifier {
  var selectedIndex = 1;

  List<Widget> screens = [
    CartScreen(),
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
