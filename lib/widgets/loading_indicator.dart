import 'package:e_mart_app/consts/consts.dart';

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(redColor),
    ),
  );
}
