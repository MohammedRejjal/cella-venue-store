// import 'package:cell_avenue_store/components/product_card.dart';
// import 'package:cell_avenue_store/models/category.dart';
// import 'package:cell_avenue_store/ui/categories/categories_provider.dart';
// import 'package:cell_avenue_store/ui/categories/category_products_provider.dart';
// import 'package:cell_avenue_store/ui/grid_products/all_products.dart';
// import 'package:cell_avenue_store/ui/grid_products/all_products_provider.dart';
// import 'package:cell_avenue_store/utilities/general.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
//
// import '../../components/loading.dart';
// import '../../models/product.dart';
//
// class CategoryWithoutImage extends StatelessWidget {
//   const CategoryWithoutImage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var viewModel = Provider.of<CategoryProductsProvider>(context);
//     var viewModelCategories = Provider.of<CategoriesProvider>(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Center(
//           child: FutureBuilder<List<Category>>(
//               future: viewModelCategories.loadCategories(context),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData &&
//                     snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.data != null) {
//                     if (snapshot.data!.isNotEmpty) {
//                       List<Category> data = snapshot.data!;
//                       viewModel.categoryType =
//                           snapshot.data!.first.id.toString();
//
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Scrollbar(
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: CustomRadioButton(
//                                     defaultSelected: "${data.first.name}",
//                                     elevation: 0,
//                                     scrollController:
//                                         viewModel.scrollController,
//                                     absoluteZeroSpacing: false,
//                                     radius: 20,
//                                     wrapAlignment: WrapAlignment.center,
//                                     enableShape: true,
//                                     selectedBorderColor:
//                                         Theme.of(context).accentColor,
//                                     unSelectedBorderColor: Colors.black38,
//                                     width: 100,
//                                     height: 40,
//                                     unSelectedColor: Colors.white38,
//                                     buttonLables:
//                                         data.map((e) => e.name!).toList(),
//                                     buttonValues:
//                                         data.map((e) => e.name!).toList(),
//                                     buttonTextStyle: ButtonTextStyle(
//                                         selectedColor: Colors.white,
//                                         unSelectedColor:
//                                             Theme.of(context).primaryColor,
//                                         textStyle: TextStyle(fontSize: 14)),
//                                     radioButtonValue: (value) {
//                                       // viewModel.categoryType = data
//                                       //     .firstWhere((element) =>
//                                       //         element.name == value)
//                                       //     .id
//                                       //     .toString();
//                                       viewModel.reloadProduct(
//                                           snapshot.data!
//                                               .firstWhere((element) =>
//                                                   element.name == value)
//                                               .id
//                                               .toString(),
//                                           context);
//                                     },
//                                     selectedColor:
//                                         Theme.of(context).accentColor,
//                                   ),
//                                 ),
//                               ),
//                               isAlwaysShown: true,
//                               controller: viewModel.scrollController,
//                             ),
//                             // buildGridProduct(context)
//                           ],
//                         ),
//                       );
//                     } else {
//                       return SizedBox();
//                     }
//                   } else {
//                     return General.showErrorDialog(context, "No data");
//                   }
//                 } else {
//                   return Loading();
//                 }
//               }),
//         ),
//         viewModel.categoryType == ""
//             ? Center(
//                 child: Loading(),
//               )
//             : buildGridProduct(context)
//       ],
//     );
//   }
//
//   buildGridProduct(context) {
//     var viewModel = Provider.of<CategoryProductsProvider>(context);
//     return Expanded(
//       child: Column(
//         children: [
//           if (viewModel.categoryType.isNotEmpty)
//             Expanded(
//               child: FutureBuilder(
//                 future: viewModel.CategoriesProduct(context),
//                 builder: (_, AsyncSnapshot<List<Product>> snapshot) {
//                   if (snapshot.hasData && viewModel.products.isNotEmpty) {
//                     return GridView.builder(
//                       physics: BouncingScrollPhysics(),
//                       controller: viewModel.scrollController,
//                       itemCount: viewModel.products.length,
//                       scrollDirection: Axis.vertical,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         childAspectRatio: .78,
//                         crossAxisCount: 2,
//                       ),
//                       itemBuilder: (context, index) {
//                         return ProdectsCart(
//                           product: viewModel.products[index],
//                         );
//                       },
//                     );
//                   }
//                   return Center(
//                     child: Loading(),
//                   );
//                 },
//               ),
//             ),
//           if (viewModel.isLoading)
//             Center(
//               child: Loading(),
//             ),
//         ],
//       ),
//     );
//   }
// }
