import 'dart:convert';

import 'package:cell_avenue_store/components/loading.dart';
import 'package:cell_avenue_store/models/category.dart';
import 'package:cell_avenue_store/ui/categories/category_provider.dart';
import 'package:cell_avenue_store/ui/grid_products/all_products.dart';
import 'package:cell_avenue_store/ui/grid_products/all_products_provider.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  // final Function() recalculateCartCount;

  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CategoryProvider>(context);

    return Container(
      child: FutureBuilder(
        future: viewModel.loadCategories(context),
        builder: (_, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                return _buildCategory(context, snapshot.data![index]);
              },
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
            );
          }
          return Center(
            child: Loading(),
          );
        },
      ),
    );
  }

  Widget _buildCategory(context, Category category) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => ChangeNotifierProvider(
                    create: (context) => AllProductsProvider(),
                    builder: (_, __) => AllProducts(
                        item: "category=${category.id!}",
                        title: category.name ?? ''),
                  ),
                ));
            // pushNewScreen(context,
            //     screen: ChangeNotifierProvider(
            //       create: (context) => AllProductsProvider(),
            //       builder: (_, __) => AllProducts(
            //           item: "category=${category.id!}",
            //           title: category.name ?? ''),
            //     ),
            //     withNavBar: false);

            //   ChangeNotifierProvider(
            //   create: (context) => AllProductsProvider(),
            //   builder: (context, _) =>
            //       AllProducts(item: "category=${category.name!}"),
            // );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: category.image == null
                      ? NetworkImage('')
                      : NetworkImage(category.image!.src!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   category.name??'',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 25),
                    // ),
                    // Text(
                    //   '${category.count} ${General.getTranslatedText(context, 'product')}',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
