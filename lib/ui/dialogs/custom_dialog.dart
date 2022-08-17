import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utilities/general.dart';

enum DialogType {
  INFO,
  ERROR,
  SUCCESS,
  WARNING,
  CHOOSE,
}

class CustomDialog extends StatelessWidget {
  final DialogType dialogType;
  final String message;
  final String buttonText;

  const CustomDialog(
      {Key? key,
      required this.dialogType,
      required this.message,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          _getCorrectIcon(),
          SizedBox(
            height: 20,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: dialogType == DialogType.CHOOSE,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(General.getTranslatedText(context, 'yes')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      side: MaterialStateProperty.all(
                        BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                      ),
                    ),
                    child: Text(General.getTranslatedText(context, 'no')),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: dialogType != DialogType.CHOOSE,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonText),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _getCorrectIcon() {
    switch (dialogType) {
      case DialogType.INFO:
      case DialogType.WARNING:
        return Lottie.asset(
          'assets/files/info.json',
          width: 150,
        );
      case DialogType.ERROR:
        return Lottie.asset(
          'assets/files/error.json',
          repeat: false,
          width: 150,
        );
      case DialogType.SUCCESS:
        return Lottie.asset(
          'assets/files/order.json',
          repeat: false,
          width: 150,
        );
      case DialogType.CHOOSE:
        return LottieBuilder.asset(
          'assets/files/choose.json',
          width: 170,
        );
    }
  }

  show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        dialogType: dialogType,
        message: message,
        buttonText: buttonText,
      ),
    );
  }
}
