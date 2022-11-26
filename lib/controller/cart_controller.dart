import 'package:e_mart_app/consts/consts.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

  var addrssControleler = TextEditingController();
  var cityControleler = TextEditingController();
  var stateControleler = TextEditingController();
  var postalCodeControleler = TextEditingController();
  var phoneControleler = TextEditingController();

  //for payment method
  var totalPay = 0.obs;
  var paymentIndex = 0.obs;

  calculatePrice({required data}) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value =
          totalPrice.value + (int.parse(data[i]['totalPrice'].toString()));
    }
  }

  changePaymentIndex({required index}) {
    paymentIndex.value = index;
  }
}
