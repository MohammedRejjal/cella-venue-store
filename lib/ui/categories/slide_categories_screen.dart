import 'package:cell_avenue_store/components/loading.dart';
import 'package:cell_avenue_store/components/product_card.dart';
import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/noConnection.dart';
import 'package:cell_avenue_store/ui/categories/categories_provider.dart';
import 'package:cell_avenue_store/ui/categories/category_products_provider.dart';
import 'package:cell_avenue_store/utilities/general.dart';
import 'package:flutter/material.dart';
import 'package:cell_avenue_store/models/category.dart';
import 'package:cell_avenue_store/main.dart' as m;
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

int? value;

class SlideCategories extends StatelessWidget {
  final ItemScrollController itemScrollController = ItemScrollController();

  SlideCategories({Key? key}) : super(key: key);

  void animateToIndex(int index) {
    itemScrollController.jumpTo(index: index, alignment: .5);
  }

  Widget CustomRadioButton(var text, int index, context) {
    var viewModelCategories = Provider.of<CategoriesProvider>(context);
    var viewModel = Provider.of<CategoryProductsProvider>(context);
    value = viewModelCategories.value;

    return Container(
      height: 20,
      child: OutlinedButton(
        onPressed: () {
          //   setState(() {

          viewModelCategories.changeValue(index);
          viewModel.changeid(text.id.toString());
          viewModel.reloadProduct(text.id.toString(), context);
          print(index);
          viewModelCategories.index = index;
          //   });
        },
        child: Text(
          text.name,
          style: TextStyle(
            color: (value == index)
                ? Colors.white
                : Theme.of(context).primaryColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            side: BorderSide(
                width: 2.5,
                color: (value == index)
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor),
            backgroundColor: (value == index)
                ? Theme.of(context).primaryColor
                : Colors.black12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<CategoryProductsProvider>(context);
    var viewModelCategories = Provider.of<CategoriesProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<List<Category>>(
              future: viewModelCategories.loadCategories(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    if (snapshot.data!.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        viewModel.changeid(snapshot.data!.first.id.toString());

                        animateToIndex(viewModelCategories.index);
                      });
                      List<Category> data = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 35,
                              child: ScrollablePositionedList.builder(
                                  //  reverse: true,
                                  itemScrollController: itemScrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: CustomRadioButton(
                                          snapshot.data![index],
                                          index,
                                          context),
                                    );
                                  }),
                            )

                            // buildGridProduct(context)
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
                  return Center(child: Loading());
                }
              },
            ),
            if (Provider.of<CategoryProductsProvider>(context, listen: false)
                    .categoryType !=
                "wait")
              buildGridProduct(context)
            else
              Center(
                child: Loading(),
              )
          ],
        ),
      ),
    );
  }

  buildGridProduct(
    context,
  ) {
    var viewModel = Provider.of<CategoryProductsProvider>(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (viewModel.categoryType.isNotEmpty ||
              viewModel.categoryType == "wait")
            Expanded(
                child: FutureBuilder(
              future: viewModel.CategoriesProduct(context),
              builder: (_, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    if (snapshot.data!.isNotEmpty) {
                      return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: viewModel.scrollController,
                        itemCount: viewModel.products.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .78,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return ProdectsCart(
                            product: viewModel.products[index],
                          );
                        },
                      );
                    } else {
                      return SizedBox(
                        child: Center(child: Text("No products")),
                      );
                    }
                  } else {
                    return General.showErrorDialog(context, "No data");
                  }
                } else {
                  return Center(child: Loading());
                }
              },
            )),
          if (viewModel.isLoading)
            Center(
              child: Loading(),
            ),
        ],
      ),
    );
  }
}
