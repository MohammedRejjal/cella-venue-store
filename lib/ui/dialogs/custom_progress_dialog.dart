import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomProgressDialog extends StatelessWidget {
  final BuildContext context;
  final bool isDismissible;
  final String? message;

  const CustomProgressDialog({
    Key? key,
    this.message,
    required this.context,
    this.isDismissible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 90,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/files/loading.json',
                  repeat: true,
                ),
                message == null ? Container() : Text(message!),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void show() {
    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => CustomProgressDialog(
        context: context,
        message: message,
      ),
    );
  }

  void hide() {
    Navigator.pop(context);
  }
}
