import 'package:e_mart_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImagePath = "".obs;

  changeImage() async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img == null) {
        return;
      } else {
        profileImagePath.value = img.path;
      }
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}
