// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/controller/product_controller.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/screens/categories_screen/item_details.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkFontGrey),
        title:
            "My Wishlists".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "No wishlists yet!"
                .text
                .fontFamily(bold)
                .size(16)
                .color(darkFontGrey)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var cartData = data[index];
                      return ListTile(
                        leading: Image.network(
                          "${cartData['p_images'][0]}",
                          width: 120,
                          fit: BoxFit.fill,
                        ),
                        title: "${cartData['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                              title: "${data[index]['p_name']}", data: data[index]));
                        }),
                        subtitle: "${cartData['p_price']}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                        trailing: Icon(
                          Icons.favorite,
                          color: redColor,
                        ).onTap(() {
                          controller.removeFromWishlist(docId: data[index].id);
                        }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
