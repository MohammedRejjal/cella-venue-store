import 'package:cell_avenue_store/components/product_card.dart';
import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/ui/grid_products/all_products_provider.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:cell_avenue_store/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/loading.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({Key? key, required this.item, required this.title})
      : super(key: key);
  final String item;
  final String title;

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<AllProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(General.getTranslatedText(context, "$title")),
      ),
      body: BuildGridView(viewModel: viewModel, item: item),
    );
  }
}

class BuildGridView extends StatelessWidget {
  const BuildGridView({
    Key? key,
    required this.viewModel,
    required this.item,
  }) : super(key: key);

  final AllProductsProvider viewModel;
  final String item;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>?>(
      future: viewModel.loadAllProducts(
          Constants.BASE_URL +
              Constants.products +
              Constants.wooAuth +
              '&per_page=10&' +
              item +
              '&status=publish&stock_status=instock',
          context),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      controller: viewModel.scrollController,
                      physics: BouncingScrollPhysics(),
                      itemCount: viewModel.allProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .7,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return ProdectsCart(
                          product: viewModel.allProducts[index],
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: viewModel.isLoading,
                    child: Loading(),
                  ),
                ],
              ),
            );
          } else {
            return General.showErrorDialog(context, "No data");
          }
        } else {
          return Center(child: Loading());
        }
      },
    );
  }
}
