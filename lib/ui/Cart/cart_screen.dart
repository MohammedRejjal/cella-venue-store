import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cell_avenue_store/components/loading.dart';
import 'package:cell_avenue_store/noConnection.dart';
import 'package:cell_avenue_store/ui/Cart/cart_screen_view_model.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cell_avenue_store/main.dart' as m;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CartScreenViewModel>(context);
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        if (await viewModel.controller.canGoBack()) {
          viewModel.controller.goBack();
          return false;
        }

        return true;
      },
      child: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: Constants.CartScreenUrl,
            onPageFinished: (url) {
              // controller.runJavascript(
              //     "document.getElementsByTagName('header')[0].style.display='none'");
              viewModel.controller.runJavascript(
                  "document.getElementsByTagName('footer')[0].style.display='none'");

              viewModel.controller.runJavascript(
                  "document.getElementsByClassName('whb-flex-row whb-general-header-inner')[0].style.display='none';");
              viewModel.loadingFinished();
            },
            onPageStarted: (url) {
              print(url);
            },
            onWebViewCreated: (c) {
              viewModel.controller = c;
            },
          ),
          Visibility(
            visible: !viewModel.isLoadingFinish,
            child: BlurryContainer(
              width: double.infinity,
              height: double.infinity,
              borderRadius: BorderRadius.zero,
              blur: 10,
              elevation: 0,
              color: Colors.transparent,
              child: Center(
                child: Loading(),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
