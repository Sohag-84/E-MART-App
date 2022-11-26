// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/consts/list.dart';
import 'package:e_mart_app/controller/cart_controller.dart';
import 'package:e_mart_app/views/screens/home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: darkFontGrey),
          title: "Choose payment methods"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: customButton(
            isLoading: controller.placingOrder.value,
            onPressed: () async {
              await controller.placeMyOder(
                paymentMethod:
                    paymentMethodNameList[controller.paymentIndex.value],
                totalAmount: controller.totalPrice.value,
              );
              await controller.clearCart();
              Fluttertoast.showToast(msg: "Order placed successfully");
              Get.offAll(() => Home());
            },
            bgColor: redColor,
            textColor: whiteColor,
            title: "Place my order",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(() {
            return Column(
                children: List.generate(paymentMethodImgList.length, (index) {
              return InkWell(
                onTap: () {
                  controller.changePaymentIndex(index: index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 3,
                      )),
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodImgList[index],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.color
                            : BlendMode.darken,
                        color: Colors.black.withOpacity(.4),
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: true,
                                onChanged: (value) {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            )
                          : Container(),
                      Positioned(
                        bottom: 10,
                        right: 5,
                        child: paymentMethodNameList[index]
                            .text
                            .white
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                      ),
                    ],
                  ),
                ),
              );
            }));
          }),
        ),
      );
    });
  }
}
