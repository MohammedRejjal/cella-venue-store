import 'dart:convert';
import 'dart:math';

import 'package:cell_avenue_store/connectivity_provider.dart';
import 'package:cell_avenue_store/models/category.dart' as ca;
import 'package:cell_avenue_store/noConnection.dart';
import 'package:cell_avenue_store/ui/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:cell_avenue_store/ui/categories/categories_provider.dart';
import 'package:cell_avenue_store/ui/categories/category_products_provider.dart';
import 'package:cell_avenue_store/ui/home/home_provider.dart';
import 'package:cell_avenue_store/ui/Cart/cart_screen.dart';
import 'package:cell_avenue_store/ui/home/home%20view/home_view.dart';
import 'package:flutter/cupertino.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:cell_avenue_store/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _MyAppState();
}

class _MyAppState extends State<BottomBar> {
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    // PersistentTabController _controller;

    // _controller = PersistentTabController(initialIndex: 1);
    var viewModel = Provider.of<BottomNavBarViewModel>(context);
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        child: BottomNavigationBar(
          items: _navBarsItems(context),
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          elevation: 4,
          onTap: viewModel.changeIndex,
          currentIndex: viewModel.selectedIndex,
        ),
      ),
      body: pageUI(viewModel.screens[viewModel.selectedIndex]),
    );

    /*
    *  PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(context),
          confineInSafeArea: true,
          backgroundColor: Theme.of(context).primaryColor,
          // Default is Colors.white.
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: false,
          popActionScreens: PopActionScreensType.once,
          itemAnimationProperties: ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style6, // Choose the nav bar style with this property.
        ))
    *
    * */
  }

  List<BottomNavigationBarItem> _navBarsItems(context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        label: "${General.getTranslatedText(context, "Cart")}",
        backgroundColor: Theme.of(context).accentColor,
        // activeColorPrimary: Theme.of(context).accentColor,
        // inactiveColorPrimary: CupertinoColors.white,
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        label: "${General.getTranslatedText(context, "Home")}",
        backgroundColor: Theme.of(context).accentColor,
        // activeColorPrimary: Theme.of(context).accentColor,
        //     inactiveColorPrimary: CupertinoColors.white,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined),
        label: "${General.getTranslatedText(context, "Categories")}",
        backgroundColor: Theme.of(context).accentColor,
        // activeColorPrimary: Theme.of(context).accentColor,
        //     inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }

  Widget pageUI(Widget screen) {
    return Consumer<ConnectivityProvider>(
      builder: (consumerContext, model, child) {
        if (model.isOnline != null) {
          return model.isOnline! ? screen : NoConnection();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
