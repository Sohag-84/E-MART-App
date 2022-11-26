import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/home_controller.dart';

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

  late dynamic productSnapshot;
  var productList = [];

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

  //for place my order
  placeMyOder({required paymentMethod, required totalAmount}) async {
    await getProductsDetails();
    await firestore.collection(orderCollection).doc().set({
      'order_code': '22345464',
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addrssControleler.text,
      'order_by_city': cityControleler.text,
      'order_by_state': stateControleler.text,
      'order_by_postalcode': postalCodeControleler.text,
      'order_by_phone_number': phoneControleler.text,
      'shipping_method': 'Home delivery',
      'payment_method': paymentMethod,
      'total_amount': totalAmount,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'order_placed': true,
      'orders': FieldValue.arrayUnion(productList),
    });
  }

  getProductsDetails() {
    productList.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      productList.add({
        'color': productSnapshot[i]['color'],
        'image': productSnapshot[i]['image'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
      });
    }
  }
}
