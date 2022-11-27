import 'package:e_mart_app/consts/consts.dart';

Widget orderPlaceDetails({
  required String title1,
  required String title2,
  required String detail1,
  required String detail2,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title1.text.fontFamily(semibold).make(),
            detail1.text.color(redColor).make(),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title2.text.fontFamily(semibold).make(),
              detail2.text.color(redColor).make(),
            ],
          ),
        ),
      ],
    ),
  );
}
