// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/cart_controller.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(uid: currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: "Cart is empty!"
                      .text
                      .color(darkFontGrey)
                      .size(18)
                      .fontFamily(bold)
                      .make());
            } else {
              var data = snapshot.data!.docs;
              cartController.calculatePrice(data: data);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var cartData = data[index];
                          return ListTile(
                            leading: Image.network("${cartData['image']}"),
                            title: "${cartData['title']} x ${cartData['quantity']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${cartData['totalPrice']}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                            trailing: Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() =>FirestoreServices.deleteCartProduct(docId: data[index].id),),
                          );
                        },
                      ),
                    ),
                    Obx(
                      () {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Total price: "
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .color(darkFontGrey)
                                .make(),
                            "${cartController.totalPrice.value}"
                                .numCurrency
                                .text
                                .fontFamily(bold)
                                .color(redColor)
                                .make(),
                          ],
                        )
                            .box
                            .roundedSM
                            .width(context.screenWidth - 60)
                            .height(60)
                            .color(lightGolden)
                            .p12
                            .make();
                      }
                    ),
                    SizedBox(
                      width: context.screenWidth - 60,
                      child: customButton(
                        isLoading: false,
                        onPressed: () {},
                        bgColor: redColor,
                        textColor: whiteColor,
                        title: "Procced to shipping",
                      ),
                    ),
                    10.heightBox,
                  ],
                ),
              );
            }
          },
        ));
  }
}
