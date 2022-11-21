// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_app/consts/consts.dart';
import 'package:e_mart_app/views/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthContorller extends GetxController {
//for button loading
  var isLoading = false.obs;

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
      if (currentUser!.uid != null) {
        storeUserData(name: name, email: email, password: password);
        Fluttertoast.showToast(msg: "Logged in successfully");
        Get.offAll(() => Home());
      }
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
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (currentUser!.uid != null) {
        storeUserData(name: name, email: email, password: password);
        Fluttertoast.showToast(msg: "Account has been created");
        Get.offAll(() => Home());
      }
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
        firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'email': email,
      'uid': currentUser!.uid,
      'imgUrl': "",
    });
  }

  //user signout
  signoutMethod() async {
    try {
      await firebaseAuth.signOut();
      Fluttertoast.showToast(msg: "Logout");
      Get.offAll(LoginScreen());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
