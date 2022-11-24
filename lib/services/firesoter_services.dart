import 'package:e_mart_app/consts/consts.dart';

class FirestoreServices {
  //get user data
  static getUser({required userUid}) {
    return firestore
        .collection(userCollection)
        .where('uid', isEqualTo: userUid)
        .snapshots();
  }

  //get products according to category
  static getProducts({required category}) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }
}
