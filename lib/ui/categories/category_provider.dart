import 'dart:convert';

import 'package:cell_avenue_store/models/category.dart';
import 'package:cell_avenue_store/models/product.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> categories = [];
  Future<List<Category>> loadCategories(context) async {
    var url = Constants.BASE_URL +
        Constants.categories +
        Constants.wooAuth +
        '&per_page=50&hide_empty=true' +
        '&status=publish&stock_status=instock';
    await HttpRequests.httpGetRequest(context, url, {}, (value, map) {
      List list = json.decode(value);
      categories.addAll(List.from(list.map((e) => Category.fromMap(e))));
    }, () {});
    return categories;
  }
}
