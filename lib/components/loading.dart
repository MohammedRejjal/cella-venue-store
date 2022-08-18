import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: Lottie.asset(
        'assets/files/loadingLott.json',
      ),
    );

    // Container(
    //   width: 80,
    //   height: 80,
    //   child: Center(
    //     child: CircularProgressIndicator.adaptive(),
    //   ));
  }
}
