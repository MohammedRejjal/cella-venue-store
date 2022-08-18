import 'dart:convert';

import 'package:cell_avenue_store/components/loading.dart';
import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/ui/home/home%20view/home_view.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  var scrollController = ScrollController();
  var products = <Product>[];
  var page = 1;
  var totalPage = 1;
  String textSearch = '';
  bool isLoading = false;
  var url = '';
  BuildContext? context;

  // buildSearchCard() {
  //   return BuildListOfCardWidget(Items: "search=${textSearch}");
  // }

  Future<void> reloadProduct(String value, context) async {
    products.clear();
    textSearch = value;
    page = 1;
    notifyListeners();
  }

  Future<List<Product>> searchProduct(context) async {
    if (products.isNotEmpty) return products;
    this.url = Constants.BASE_URL +
        Constants.products +
        Constants.wooAuth +
        '&page=1&per_page=10&status=publish&stock_status=instock&' +
        "search=$textSearch";
    this.context = context;
    await HttpRequests.httpGetRequest(context, url, {}, (value, map) {
      print("object------------------------------------++");
      List list = json.decode(value);
      list.forEach((element) {
        products.add(Product.fromJson(element));
      });
      totalPage = int.parse(map[Constants.TOTAL_PAGES_KEY] ?? '1');
      scrollController.addListener(_scrollListener);
    }, () {});
    // notifyListeners();
    return products;
  }

  void _scrollListener() {
    if (page != totalPage && page < totalPage) {
      if (scrollController.position.extentAfter <= 0 && !isLoading) {
        _loadMore();
      }
    } else {
      scrollController.removeListener(_scrollListener);
    }
  }

  Future<List<Product>> _loadMore() async {
    page++;
    url += '&page=$page';
    isLoading = true;
    notifyListeners();
    await HttpRequests.httpGetRequest(context, url, {}, (value, map) {
      List list = json.decode(value);
      list.forEach((element) {
        products.add(Product.fromJson(element));
      });
    }, () {});
    isLoading = false;
    notifyListeners();
    return products;
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
