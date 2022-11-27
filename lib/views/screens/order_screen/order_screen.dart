// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/services/firesoter_services.dart';
import 'package:e_mart_app/views/screens/order_screen/order_details.dart';
import 'package:e_mart_app/widgets/loading_indicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkFontGrey),
        title: "My orders".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders yet!"
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
                  leading: "${index + 1}.".text.xl3.color(darkFontGrey).make(),
                  title: "Order Code: ${data[index]['order_code']}"
                      .text
                      .fontFamily(semibold)
                      .color(redColor)
                      .make(),
                  subtitle: "Total: ${data[index]['total_amount']} BDT"
                      .toString()
                      .text
                      .fontFamily(semibold)
                      .make(),
                  trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrderDetailsScreen(data: data[index]));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: darkFontGrey,
                      )),
                );
              },
            );
          }
        },
      ),
    );
  }
}
