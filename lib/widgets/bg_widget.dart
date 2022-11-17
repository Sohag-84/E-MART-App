// ignore_for_file: prefer_const_constructors

import 'package:e_mart_app/consts/consts.dart';

Widget bgWidget({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
