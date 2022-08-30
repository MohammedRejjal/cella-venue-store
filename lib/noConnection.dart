import 'package:cell_avenue_store/utilities/general.dart';
import 'package:cell_avenue_store/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/files/no_internet_connection.json',
              repeat: true,
              width: getScreenWidth() / 4,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              General.getTranslatedText(context, "checkOfNetwork"),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
