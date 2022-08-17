import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

late WebViewController controller;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = await canGoBack();
        return result;
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.reload();
            return;
          },
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: "https://cellavenuestore.com/cart/",
            onPageFinished: (url) {
              controller.runJavascript(
                  "document.getElementsByTagName('header')[0].style.display='none'");
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
