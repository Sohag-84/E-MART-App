import 'package:e_mart_app/consts/consts.dart';
import 'package:flutter/services.dart';

Widget exitDialog() {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.color(darkFontGrey).size(18).fontFamily(bold).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        15.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
              isLoading: false,
              onPressed: () {
                SystemNavigator.pop();
              },
              bgColor: redColor,
              textColor: whiteColor,
              title: "Yes",
            ),
            10.heightBox,
            customButton(
              isLoading: false,
              onPressed: () {
                Get.back();
              },
              bgColor: redColor,
              textColor: whiteColor,
              title: "No",
            ),
          ],
        ),
      ],
    ).box.roundedSM.p12.color(lightGrey).make(),
  );
}
