import 'dart:developer';
import 'dart:io';

import 'package:atan_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../data/models/user_model.dart';

class AuthController extends GetxController {
  var isAuth = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();

//akun yg sudah login disimpan di currentuser
  GoogleSignInAccount? _currentUser;

//data yang diperlukan untuk login disimpan di usercredential
  UserCredential? userCredential;

//inisialisasi database firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  //UserModel userData = UserModel();

  Future<void> firstInitialized() async {
    await autoLogin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
  }

  Future<bool> autoLogin() async {
    //auto login
    try {
      final isSignIn = await _googleSignIn.isSignedIn();
      if (isSignIn) {
        return true;
      }
      return false;
    } catch (e) {
      // Dialog(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //   backgroundColor: Colors.white,
      //   child: Container(
      //     width: 193.93,
      //     height: 194.73,
      //     child: Column(
      //       children: [Icon(PhosphorIcons.xCircle)],
      //     ),
      //   ),
      // );
      return false;
    }
  }

  Future signInGoogle() async {
    await _googleSignIn.signOut();

    _currentUser =
        await _googleSignIn.signIn().then((value) => _currentUser = value);

    final isSignIn = await _googleSignIn.isSignedIn();

    if (isSignIn) {
      GoogleSignInAuthentication? googleAuthSign =
          await _currentUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuthSign?.accessToken,
          idToken: googleAuthSign?.idToken);

      await auth
          .signInWithCredential(credential)
          .then((value) => userCredential = value);

      log("$userCredential");

      isAuth.value = true;

      await Get.offAllNamed(Routes.HOME);

//inisiasi collection yg akan dipakai
      CollectionReference users = firestore.collection("users");

      DateTime now = DateTime.now();

      String emailUser = auth.currentUser!.email.toString();

      final checkuser = await users.doc(emailUser).get();

      if (checkuser.data() == null) {
        users.doc(emailUser).set({
          "uid": userCredential!.user!.uid,
          "name": _currentUser!.displayName,
          "email": _currentUser!.email,
          "photoUrl": _currentUser!.photoUrl,
          "roles": "user",
          "creationTime":
              userCredential!.user!.metadata.creationTime!.toIso8601String(),
          "lastSignInTime":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
          "updatedTime": now.toIso8601String()
        });
      } else {
        users.doc(emailUser).update({
          "lastSignInTime":
              userCredential!.user!.metadata.lastSignInTime?.toIso8601String(),
        });
      }
    } else {
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Container(
          width: 193.93,
          height: 194.73,
          child: Column(
            children: [Icon(PhosphorIcons.xCircle)],
          ),
        ),
      ));
    }
  }

  Future<void> logout() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  // Future<void> storeDataUser() async {}

  // Future getDataUser() async {
  //   return firestore
  //       .collection("users")
  //       .doc(_currentUser?.email)
  //       .snapshots()
  //       .map((DocumentSnapshot<Map<String, dynamic>> snap) =>
  //           UserModel.fromJson(snap.data()!));
  // }

  Future<DocumentSnapshot<Object?>> getUserRole() async {
    String? emailUser = auth.currentUser!.email;
    DocumentReference userss = firestore.collection("users").doc(emailUser);
    return userss.get();
  }
}
