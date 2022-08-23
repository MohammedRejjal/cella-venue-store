import 'dart:convert';

import 'package:cell_avenue_store/models/category.dart';
import 'package:cell_avenue_store/utilities/constants.dart';
import 'package:cell_avenue_store/utilities/http_requests.dart';
import 'package:flutter/material.dart';

class CategoriesProvider with ChangeNotifier {
  int value = 0;
  int index = 0;
  List<Category> categories = [];
  changeValue(int index) {
    value = index;
    //  notifyListeners();
  }
  // int get value => _value;
  // int get index => _index;
  // List<Category> get categories => _categories;

  Future<List<Category>>? loadCategories(context) async {
    if (categories.isNotEmpty) return categories;

    print("object++++++++----");
    var url = Constants.BASE_URL +
        Constants.categories +
        Constants.wooAuth +
        '&per_page=50&hide_empty=true' +
        '&status=publish&stock_status=instock';
    await HttpRequests.httpGetRequest(context, url, {}, (value, map) {
      print("object------------------------------------++++");

      List list = json.decode(value);
      categories.addAll(List.from(list.map((e) => Category.fromMap(e))));
      print("======" + "$categories");
    }, () {});
    print("object_--_-------");
    return categories;
  }
}
