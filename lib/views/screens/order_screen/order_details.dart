// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/views/screens/order_screen/components/order_place_details.dart';
import 'package:e_mart_app/views/screens/order_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailsScreen extends StatelessWidget {
  final dynamic data;
  const OrderDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: darkFontGrey),
        title: "Order Details".text.fontFamily(semibold).make(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
              icon: Icons.done,
              title: "Placed",
              color: redColor,
              showDone: data["order_placed"],
            ),
            orderStatus(
              icon: Icons.thumb_up,
              title: "Confirmed",
              color: Colors.blue,
              showDone: data["order_confirmed"],
            ),
            orderStatus(
              icon: Icons.car_crash,
              title: "On Delivery",
              color: Colors.yellow,
              showDone: data["order_delivered"],
            ),
            orderStatus(
              icon: Icons.done_all,
              title: "Delivered",
              color: Colors.purple,
              showDone: data["order_on_delivery"],
            ),
            Divider(
              color: darkFontGrey,
              height: 3,
            ),
            Column(
              children: [
                orderPlaceDetails(
                  title1: "Order Code",
                  title2: "Shipping Method",
                  detail1: data['order_code'],
                  detail2: data['shipping_method'],
                ),
                orderPlaceDetails(
                  title1: "Order Date",
                  title2: "Payment Method",
                  detail1: intl.DateFormat()
                      .add_yMd()
                      .format(data['order_date'].toDate()),
                  detail2: data['payment_method'],
                ),
                orderPlaceDetails(
                  title1: "Payment Status",
                  title2: "Delivery Status",
                  detail1: "Unpaid",
                  detail2: "Order Placed",
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "Name: ${data["order_by_name"]}"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                            "Email: ${data["order_by_email"]}"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                            "Address: ${data["order_by_address"]}"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                            "City: ${data["order_by_city"]}"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                            "Country: Bangladesh"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                            "State: ${data["order_by_state"]}"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                            "Phone: ${data["order_by_phone_number"]}"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                            "Postal code: ${data["order_by_postalcode"]}"
                                .text
                                .color(darkFontGrey.withOpacity(.60))
                                .make(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['total_amount']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).box.outerShadowMd.white.make(),
            Divider(
              color: darkFontGrey,
              height: 3,
            ),
            10.heightBox,
            "Ordered Product"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .size(16)
                .makeCentered(),
            10.heightBox,
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(data['orders'].length, (index) {
                var orderData = data['orders'][index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                      title1: orderData['title'],
                      title2: orderData['total_price'].toString(),
                      detail1: "Quantity: ${orderData['quantity']}",
                      detail2: 'Refundable',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Container(
                        height: 20,
                        width: 30,
                        color: Color(int.parse(orderData['color'])),
                      ),
                    ),
                    Divider()
                  ],
                );
              }).toList(),
            ).box.outerShadowMd.white.make(),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
