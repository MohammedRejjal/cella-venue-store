import 'package:cell_avenue_store/ui/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:cell_avenue_store/ui/home/home_provider.dart';
import 'package:cell_avenue_store/ui/Home/home%20view/home_view.dart';
import 'package:cell_avenue_store/ui/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:cell_avenue_store/ui/search/search_provider.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

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

class MyApp extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    var localSnapshot = Provider.of<KLocalizations>(context);
    return MaterialApp(
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
            elevation: 0,
            centerTitle: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ))),
      ),
      home: ChangeNotifierProvider(
        builder: (context, _) => BottomBar(),
        create: (context) => BottomNavBarViewModel(),
      ),
    );
  }
}
