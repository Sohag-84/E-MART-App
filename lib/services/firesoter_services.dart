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

  //get products according to subcategory
  static getSubcategoryProducts({required subcategory}) {
    return firestore
        .collection(productCollection)
        .where('p_subcategory', isEqualTo: subcategory)
        .snapshots();
  }

  //get cart data
  static getCart({required uid}) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //for delete cart product
  static deleteCartProduct({required docId}) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get all chat mesage
  static getChatMessages({required docId}) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //get user all orders
  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //get wishlists
  static getWishlists() {
    return firestore
        .collection(productCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  //get user messages
  static getMesssages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

//for cart, wishlist and order count
  static getCount() async {
    var res = await Future.wait(
      [
        firestore
            .collection(cartCollection)
            .where('added_by', isEqualTo: currentUser!.uid)
            .get()
            .then((value) {
          return value.docs.length;
        }),
        firestore
            .collection(productCollection)
            .where('p_wishlist', arrayContains: currentUser!.uid)
            .get()
            .then((value) {
          return value.docs.length;
        }),
        firestore
            .collection(orderCollection)
            .where('order_by', isEqualTo: currentUser!.uid)
            .get()
            .then((value) {
          return value.docs.length;
        }),
      ],
    );
    return res;
  }

  // for all products
  static getAllProducts() {
    return firestore.collection(productCollection).snapshots();
  }

  //get featured product method
  static getFeaturedProduct() {
    return firestore
        .collection(productCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  //for search product
  static searchProducts({required title}) {
    return firestore.collection(productCollection).get();
  }
}
