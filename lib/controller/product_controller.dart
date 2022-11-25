import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductController extends GetxController {
//for product quantity
  var quantity = 0.obs;

  //for color index
  var colorIndex = 0.obs;

  //for total price
  var totalPrice = 0.obs;

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

  changeColorIndex({required index}) {
    colorIndex.value = index;
  }

  increaseQuatity({required totalQuantity}) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    } else {
      Fluttertoast.showToast(msg: "Out of stock");
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice({required productPrice}) {
    totalPrice.value = productPrice * quantity.value;
  }

  addToCart({
    required title,
    required img,
    required sellerName,
    required color,
    required quantity,
    required totalPrice,
  }) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'image': img,
      "sellerName": sellerName,
      "color": color,
      "quantity": quantity,
      "totalPrice": totalPrice,
      "added_by": currentUser!.uid,
    }).catchError(
      (error) => Fluttertoast.showToast(
        msg: error.toString(),
      ),
    );
  }

  resetValue() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }
}

