// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';

Widget customButton(
    {required bool isLoading,
    required VoidCallback onPressed,
    required bgColor,
    required textColor,
    required String title}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      padding: EdgeInsets.all(12),
    ),
    child: isLoading
        ? "Loading..".text.white.fontFamily(bold).make():title.text.color(textColor).fontFamily(bold).make()
  );
}
