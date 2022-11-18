import 'package:e_mart_app/consts/consts.dart';

Widget homeButton({required VoidCallback onPressed,required width, required height, required String title, required icon}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 32,),
      10.heightBox,
      title.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.rounded.size(width, height).white.make().onTap(onPressed);
}