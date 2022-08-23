import 'dart:io';

import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/ui/home/home_provider.dart';
import 'package:cell_avenue_store/ui/product_details/details_screen.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:cell_avenue_store/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProdectsCart extends StatefulWidget {
  const ProdectsCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProdectsCart> createState() => _ProdectsCartState();
}

class _ProdectsCartState extends State<ProdectsCart> {
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => DetailsScreen(url: widget.product.permalink),
                ));
            // pushNewScreen(context,
            //     screen: DetailsScreen(url: widget.product.permalink),
            //     withNavBar: false);
          },
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        "${widget.product.images[0].src}",
                        height: getScreenHeight() / 5,
                        width: getScreenWidth() / 5,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      widget.product.name,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    // Text(viewModel.products[index].regularPrice),
                    Html(
                      data: widget.product.priceHtml,
                    )
                    // Text(html2md.convert(
                    //     viewModel.products[index].priceHtml)),
                  ],
                ),
              )),
        ),
        buildDiscount(
          context,
          // snapshot.data![index],
          widget.product,
        )
      ],
    );
  }

  buildDiscount(BuildContext context, Product product) {
    return product.onSale
        ? Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    General.getTranslatedText(context, "SpecialOffer"),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  String calculateOffer(String regularPrice, String salePrice) {
    double result;
    int sale, regular, def;
    sale = int.parse(salePrice);
    regular = int.parse(regularPrice);
    def = regular - sale;
    result = 100 * def / regular;
    return result.toStringAsFixed(1) + "%";
  }
}
