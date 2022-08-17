import 'package:cell_avenue_store/components/loading.dart';
import 'package:cell_avenue_store/components/product_card.dart';
import 'package:cell_avenue_store/components/search_text_field.dart';
import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/ui/home/home_provider.dart';
import 'package:cell_avenue_store/ui/home/home%20view/home_view.dart';
import 'package:cell_avenue_store/ui/search/search_provider.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:cell_avenue_store/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModelSearch = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cell Avenue Store"),
      ),
      body: Column(
        children: [
          SearchTextField(readonly: false),
          Expanded(child: BuildGrid())
        ],
      ),
    );
  }
}

class BuildGrid extends StatelessWidget {
  const BuildGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModelSearch = Provider.of<SearchProvider>(context);

    return viewModelSearch.products.isNotEmpty
        ? FutureBuilder<List<Product>?>(
            future: viewModelSearch.searchProduct(
                viewModelSearch.textSearch, context),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return Container(
                    height: getScreenHeight() / 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: viewModelSearch.scrollController,
                            itemCount: viewModelSearch.products.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .78,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return ProdectsCart(
                                product: viewModelSearch.products[index],
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: viewModelSearch.isLoading,
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
          )
        : SizedBox();
  }
}
