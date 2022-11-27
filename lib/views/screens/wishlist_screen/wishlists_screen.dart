// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: data[index]['p_price']
                        .toString()
                        .text
                        .fontFamily(semibold)
                        .color(redColor)
                        .make(),
                        subtitle: data[index]['p_rating']
                        .toString()
                        .text
                        .fontFamily(semibold)
                        .color(redColor)
                        .make(),
                  );
                });
          }
        },
      ),
    );
  }
}
