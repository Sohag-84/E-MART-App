import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthContorller extends GetxController {
  //user login
  Future<UserCredential?> loginMethod({
    required email,
    required password,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return userCredential;
  }

  //user signup
  Future<UserCredential?> signupMethod({
    required name,
    required email,
    required password,
    required retypePasswrod,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return userCredential;
  }

  //storing user darta
  storeUserData({
    required name,
    required email,
    required password,
  }) async {
    DocumentReference store =
        firestore.collection(userCollection).doc(currenUser!.uid);
    store.set({
      'name': name,
      'email': email,
      'password': password,
      'imgUrl': "",
    });
  }

  //user signout
  signoutMethod() async {
    try {
      await firebaseAuth.signOut();
      Fluttertoast.showToast(msg: "log out");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
