import 'dart:convert';

import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  Future<List<Product>> loadProducts(url, context) async {
    print("object++++++++");
    List<Product> products = [];

    await HttpRequests.httpGetRequest(context, url, {}, (value, map) {
      print("object------------------------------------");
      List list = json.decode(value);
      list.forEach((element) {
        products.add(Product.fromJson(element));
        print("object++++++++");
      });
    }, () {});
    return products;
  }
}
