// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';

Widget customTextField(
    {required String title, required String hintText, required controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: textFieldGrey,
            fontFamily: semibold,
          ),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
          ),
        ),
      ),
    ],
  );
}
