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
import 'package:lottie/lottie.dart';
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
        body: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: getScreenHeight(),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       bottomRight: Radius.circular(60),
              //       bottomLeft: Radius.circular(60)),
              //
              // ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SearchTextField(readonly: false),
                SizedBox(
                  height: 20,
                ),
                _buildGridProduct(context),
                // Expanded(child: BuildGrid())
              ],
            )
          ],
        ));
  }
}

_buildGridProduct(context) {
  var viewModel = Provider.of<SearchProvider>(context);
  return Expanded(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60)),
              color: Colors.white),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              if (viewModel.textSearch.isNotEmpty)
                Expanded(
                  child: FutureBuilder(
                    future: viewModel.searchProduct(context),
                    builder: (_, AsyncSnapshot<List<Product>> snapshot) {
                      if (snapshot.hasData && viewModel.products.isNotEmpty) {
                        return GridView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: viewModel.scrollController,
                          itemCount: viewModel.products.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .78,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return ProdectsCart(
                              product: viewModel.products[index],
                            );
                          },
                        );
                      } else if (snapshot.hasData &&
                          viewModel.products.isEmpty &&
                          snapshot.connectionState == ConnectionState.done)
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset('assets/files/search.json',
                                  width: 250, height: 250),
                              Text(
                                General.getTranslatedText(
                                    context, 'searchNotFound'),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      return Center(
                        child: Loading(),
                      );
                    },
                  ),
                ),
              if (viewModel.isLoading)
                Center(
                  child: Loading(),
                ),
              if (viewModel.textSearch.isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset(
                        'assets/files/search.json',
                        repeat: true,
                        width: getScreenWidth() / 3,
                      ),
                    ),
                  ],
                )
            ],
          )));
}

class BuildGrid extends StatelessWidget {
  const BuildGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModelSearch = Provider.of<SearchProvider>(context);
    return viewModelSearch.products.isNotEmpty
        ? Expanded(
            child: FutureBuilder<List<Product>>(
              future: viewModelSearch.searchProduct(context),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return Container(
                      height: getScreenHeight() / 3,
                      child: Column(
                        children: [
                          GridView.builder(
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
            ),
          )
        : SizedBox();
  }
}
