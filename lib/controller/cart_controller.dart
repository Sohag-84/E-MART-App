import 'package:e_mart_app/consts/consts.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

  calculatePrice({required data}) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value =
          totalPrice.value + (int.parse(data[i]['totalPrice'].toString()));
    }
  }
}
