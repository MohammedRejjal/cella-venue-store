import 'dart:async';

import 'package:cell_avenue_store/connectivity_provider.dart';
import 'package:cell_avenue_store/noConnection.dart';
import 'package:cell_avenue_store/test_screen.dart';
import 'package:cell_avenue_store/ui/Cart/cart_screen.dart';
import 'package:cell_avenue_store/ui/categories/categories_provider.dart';
import 'package:cell_avenue_store/ui/categories/category_products_provider.dart';
import 'package:cell_avenue_store/ui/splash_screen/Splashscreen.dart';
import 'package:cell_avenue_store/ui/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:cell_avenue_store/ui/home/home_provider.dart';
import 'package:cell_avenue_store/ui/Home/home%20view/home_view.dart';
import 'package:cell_avenue_store/ui/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:cell_avenue_store/ui/search/search_provider.dart';
import 'package:cell_avenue_store/ui/splash_screen/Splashscreen.dart';
import 'package:cell_avenue_store/ui/categories/slide_categories_screen.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';

var isConnected = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    KLocalizations.asChangeNotifier(
      locale: Locale(await General.getStringSP('lang') ?? 'ar'),
      defaultLocale: Locale('ar'),
      supportedLocales: [Locale('en'), Locale('ar')],
      localizationsAssetsPath: 'lang',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   initConnectivity();
  //
  //   setState(() => _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus));
  // }
  //
  // @override
  // void dispose() {
  //   _connectivitySubscription.cancel();
  //   super.dispose();
  // }
  //
  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //
  //   return _updateConnectionStatus(result);
  // }
  //
  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  // }

  MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final ds = 0.5 - strength;

      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  StreamController<bool> conntectionController = StreamController.broadcast();
  Stream<ConnectivityResult> connectivityStream =
      Connectivity().onConnectivityChanged;

  @override
  Widget build(BuildContext context) {
    var localSnapshot = Provider.of<KLocalizations>(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CategoryProductsProvider(),
          ),
          ChangeNotifierProvider(create: (context) => CategoriesProvider()),
          ChangeNotifierProvider(
            create: (context) => ConnectivityProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // navigatorObservers: [
            //   FirebaseAnalyticsObserver(analytics: analytics),
            // ],

            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              localSnapshot.delegate,
            ],
            supportedLocales: localSnapshot.supportedLocales,
            locale: localSnapshot.locale,
            title: 'cell avenue store',
            theme: ThemeData(
              primarySwatch: createMaterialColor(Color(0xFF632a7e)),
              accentColor: Color(0xFFfecf09),
              appBarTheme: AppBarTheme(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(10),
                //     bottomRight: Radius.circular(10),
                //   ),
                // ),              elevation: 0,
                centerTitle: true,
                //
              ),
            ),
            home: SplashScreen()));
  }

  // StreamBuilder(
  // stream: Connectivity().onConnectivityChanged,
  // builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
  // isConnected = snapshot.hasData;
  // return Connectivity().onConnectivityChanged ==
  // ConnectivityResult.none
  // ? NoConnection()
  //     : SplashScreen();
  // },
  // ),
  checkInternetConnection() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult event) async {
      isConnected = await InternetConnectionChecker().hasConnection;
      print(isConnected);
      conntectionController.sink.add(isConnected);
    });
  }

  // @override
  // void initState() {
  //   checkInternetConnection();
  //   super.initState();
  // }
}

//
// StreamBuilder<ConnectivityResult>(
// stream: connectivityStream,
// builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
// final connectivityResult = snapshot.data;
// return connectivityResult == ConnectivityResult.none
// ? NoConnection()
//     : SplashScreen();
// },
// ),
// StreamBuilder(
// stream: Connectivity().onConnectivityChanged,
// builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
// return snapshot.data == ConnectivityResult.mobile ||
// snapshot.data == ConnectivityResult.wifi
// ? OnlineMaterialApp()
//     : OfflineMaterialApp();
// },
// ),
