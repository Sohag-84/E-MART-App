// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';

Widget senderBubble() {
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: redColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Message here....".text.size(16).color(whiteColor).make(),
        10.heightBox,
        "10:12 am".text.color(whiteColor.withOpacity(.70)).make()
      ],
    ),
  );
}
