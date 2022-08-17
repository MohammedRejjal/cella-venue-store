import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ));
  }
}
