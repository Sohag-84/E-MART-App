import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/models/category_model.dart';
import 'package:flutter/services.dart';

class ProductController extends GetxController {
//for product quantity
  var quantity = 0.obs;

  //subcategories list
  var subcat = [];
  getSubcategories({required title}) async {
    subcat.clear(); //otherwise subcategory list add continusly
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);

    List categoryName =
        decoded.categories.where((element) => element.name == title).toList();

//since threre are one list in the json file.so use categoryName[0]
    for (var item in categoryName[0].subcategories) {
      subcat.add(item);
    }
  }
}
