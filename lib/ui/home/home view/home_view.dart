import 'dart:convert';
import 'dart:math';

import 'package:cell_avenue_store/components/loading.dart';
import 'package:cell_avenue_store/components/product_card.dart';
import 'package:cell_avenue_store/ui/grid_products/all_products.dart';
import 'package:cell_avenue_store/ui/grid_products/all_products_provider.dart';
import 'package:cell_avenue_store/ui/home/home_provider.dart';
import 'package:cell_avenue_store/components/search_text_field.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:cell_avenue_store/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../noConnection.dart';
import '../../search/search_provider.dart';
import '../../search/search_screen.dart';
import 'package:cell_avenue_store/main.dart' as m;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeProvider>(context, listen: false);
    SizeConfig(context);
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: getScreenHeight() / 4,
        ),
        Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        color: Colors.white,
                        child: Image.asset(
                          'assets/cell-avenue-logo-ai.png',
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: _buildSearchDesign(context),
                  ),
                  Container(
                    height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        _buildGrid(context,
                            viewModel: viewModel,
                            item: "",
                            title: "latestItems"),
                        _buildGrid(
                          context,
                          viewModel: viewModel,
                          item: "on_sale=true",
                          title: "Offers",
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        _buildGrid(
                          context,
                          viewModel: viewModel,
                          item: "featured=true",
                          title: "featured",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            )
          ],
        ),
      ],
    )));
  }

  _buildSearchDesign(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Material(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        elevation: 4.0,
        shadowColor: Colors.black,
        child: TextField(
          textInputAction: TextInputAction.search,
          readOnly: true,
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                          create: (context) => SearchProvider(),
                          builder: (_, __) => SearchScreen(),
                        )));
            // pushNewScreen(context,
            //     screen: ChangeNotifierProvider(
            //       create: (context) => SearchProvider(),
            //       builder: (_, __) => SearchScreen(),
            //     ),
            //     withNavBar: false);
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            prefixIcon: Container(
                margin: EdgeInsets.all(5),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.search,
                )),
            hintText: General.getTranslatedText(context, "Search"),
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          ),
        ),
      ),
    );
  }

  _buildGrid(context,
      {required HomeProvider viewModel,
      required String item,
      required String title}) {
    return FutureBuilder<List<Product>?>(
      future: viewModel.loadProducts(
          Constants.BASE_URL +
              Constants.products +
              Constants.wooAuth +
              '&page=1&per_page=10&' +
              item +
              '&status=publish&stock_status=instock',
          context),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              print(title + "${snapshot.data!.length}");
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60)),
                  color: Colors.white,
                ),
                height: getScreenHeight() / 2.4,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child:
                          _buildHeaderOfCard(context, title: title, item: item),
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 4 / 3,
                          crossAxisCount: 1,
                        ),
                        itemBuilder: (context, index) {
                          return ProdectsCart(
                            product: snapshot.data![index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          } else {
            return General.showErrorDialog(context, "No data");
          }
        } else {
          return Loading();
        }
      },
    );
  }

  _buildHeaderOfCard(context, {required String item, required String title}) {
    return ListTile(
      title: Text(
        General.getTranslatedText(context, title),
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      trailing: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (context) => AllProductsProvider(),
                    builder: (_, __) => AllProducts(item: item, title: title),
                  ),
                ));
            // pushNewScreen(context,
            //     screen: ChangeNotifierProvider(
            //       create: (context) => AllProductsProvider(),
            //       builder: (_, __) => AllProducts(item: item, title: title),
            //     ),
            //     withNavBar: false);
          },
          child: Text(General.getTranslatedText(context, 'MoreItem'))),
    );
  }
}
