import 'dart:convert';

import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:flutter/material.dart';

class AllProductsProvider with ChangeNotifier {
  var scrollController = ScrollController();

  var page = 1;
  var totalPage = 1;

  bool isLoading = false;
  var url = '';
  BuildContext? context;
  List<Product> allProducts = [];

  Future<List<Product>> loadAllProducts(url, context) async {
    if (allProducts.isNotEmpty) return allProducts;
    this.url = url;
    this.context = context;
    await HttpRequests.httpGetRequest(context, url, {}, (value, map) {
      List list = json.decode(value);
      list.forEach((element) {
        allProducts.add(Product.fromJson(element));
      });
      totalPage = int.parse(map[Constants.TOTAL_PAGES_KEY] ?? '1');
      scrollController.addListener(_scrollListener);
    }, () {});
    return allProducts;
  }

  Future<List<Product>> _loadMore() async {
    page++;
    url += '&page=$page';
    isLoading = true;
    notifyListeners();
    await HttpRequests.httpGetRequest(context, url, {}, (value, map) {
      List list = json.decode(value);
      list.forEach((element) {
        allProducts.add(Product.fromJson(element));
      });
    }, () {});
    isLoading = false;
    notifyListeners();
    return allProducts;
  }
// List<Product>? spacificProduct = [];
// Future<List<Product>> loadSpecificCategories(int? catId) async {
//   WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
//       url: "${Constants.baseURL}",
//       consumerKey: "${Constants.consumerKey}",
//       consumerSecret: "${Constants.consumerSecret}");
//
//   var json = await wooCommerceAPI
//       .getAsync("products/?page=2&per_page=20&category=$catId");
//   spacificProduct = productFromJson(json);
//   print("+++++++++++++++++");
//   print(spacificProduct);
//
//   return spacificProduct!;
// }

  void _scrollListener() {
    if (page != totalPage && page < totalPage) {
      if (scrollController.position.extentAfter <= 0 && !isLoading) {
        _loadMore();
      }
    } else {
      scrollController.removeListener(_scrollListener);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
