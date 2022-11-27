import 'package:e_mart_app/consts/consts.dart';

Widget orderStatus(
    {required icon, required String title, required Color color, required bool showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.p4.make(),
    title: Container(height:2,color: darkFontGrey),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          title.text.color(darkFontGrey).size(15).make(),
          showDone
              ? Icon(
                  icon,
                  color: color,
                )
              : Container(),
        ],
      ),
    ),
  );
}
