import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

late WebViewController controller;

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.url}) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = await canGoBack();
        return result;
      },
      child: Scaffold(
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url,
          onPageFinished: (url) {
            // controller.runJavascript(
            //     "document.getElementsByTagName('header')[0].style.display='none'");
            controller.runJavascript(
                "document.getElementsByTagName('footer')[0].style.display='none'");
          },
          onPageStarted: (url) {
            print(url);
          },
          onWebViewCreated: (c) {
            controller = c;
          },
        ),
      ),
    );
  }
}

Future<bool> canGoBack() async {
  if (await controller.canGoBack()) {
    print("onwill goback");
    controller.goBack();
    return false;
  }

  return true;
}
