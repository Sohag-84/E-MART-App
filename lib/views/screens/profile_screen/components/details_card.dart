import 'package:e_mart_app/consts/consts.dart';

Widget detailsCard(
    {required String count, required String title, required double width}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title.text.color(darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).height(60).p4.make();
}
