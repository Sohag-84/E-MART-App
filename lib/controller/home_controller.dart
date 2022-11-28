import 'dart:developer';

import 'package:e_mart_app/consts/consts.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;

  //for search bar
  var searchController = TextEditingController();

  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var username = '';
  getUsername() async {
    var name = await firestore
        .collection(userCollection)
        .where('uid', isEqualTo: currentUser!.uid)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          return value.docs.single['name'];
        }
      },
    );
    username = name;
    log("Username: $name");
  }
}
