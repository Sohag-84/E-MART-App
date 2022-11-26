// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/cart_controller.dart';
import 'package:e_mart_app/views/screens/cart_screen/payment_method.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShippingDetailsScreen extends StatelessWidget {
  const ShippingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkFontGrey),
        title: "Shipping info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: customButton(
          isLoading: false,
          onPressed: () {
            if (controller.addrssControleler.text.length < 5) {
              Fluttertoast.showToast(
                  msg: 'Address must be at least 5 character');
            } else if (controller.cityControleler.text.length < 3) {
              Fluttertoast.showToast(
                  msg: 'City name must be at least 3 character');
            } else if (controller.stateControleler.text.length < 4) {
              Fluttertoast.showToast(
                  msg: 'State name must be at least 4 character');
            } else if (controller.postalCodeControleler.text.length < 3) {
              Fluttertoast.showToast(
                  msg: 'Postal code must be at least 3 character');
            } else if (controller.phoneControleler.text.length < 11) {
              Fluttertoast.showToast(
                  msg: 'Phone number must be at least 11 character');
            } else {
              Get.to(() => PaymentMethods());
            }
          },
          bgColor: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customTextField(
                title: "Address",
                hintText: "Address",
                controller: controller.addrssControleler,
              ),
              5.heightBox,
              customTextField(
                title: "City",
                hintText: "City",
                controller: controller.cityControleler,
              ),
              5.heightBox,
              customTextField(
                title: "State",
                hintText: "State",
                controller: controller.stateControleler,
              ),
              5.heightBox,
              customTextField(
                title: "Postal Code",
                hintText: "Postal Code",
                controller: controller.postalCodeControleler,
              ),
              5.heightBox,
              customTextField(
                title: "Phone",
                hintText: "Phone",
                controller: controller.phoneControleler,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
