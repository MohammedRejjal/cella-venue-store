import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      child: Lottie.asset(
        'assets/files/loading3.json',
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
