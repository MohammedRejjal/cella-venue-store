import 'dart:async';

import 'package:cell_avenue_store/onbording/onBording_provider.dart';
import 'package:cell_avenue_store/onbording/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
                builder: (context, _) => OnBoardingScreen(),
                create: (context) => OnBordingProvider(),
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.network(
              'https://cellavenuestore.com/wp-content/uploads/2021/09/cell-avenue-logo-ai.png',
              height: 120,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 120,
              height: 120,
              child: Lottie.asset(
                'assets/files/loading4.json',
              ),
            )
          ],
        ),
      ),
    );
  }
}