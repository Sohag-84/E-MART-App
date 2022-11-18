// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';

Widget featuredButton({required img,required String title}) {
  return Row(
    children: [
      Image.asset(img,width: 60,fit: BoxFit.fill,),
      10.heightBox,
      title.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.width(200).white.p8.margin(EdgeInsets.symmetric(horizontal: 5)).roundedSM.outerShadow.make();
}
