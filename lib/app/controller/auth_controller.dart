import 'dart:developer';

import 'package:atan_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../data/models/user_model.dart';
import '../util/color.dart';

class AuthController extends GetxController {
  var isAuth = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

//akun yg sudah login disimpan di currentuser
  GoogleSignInAccount? _currentUser;

//data yang diperlukan untuk login disimpan di usercredential
  UserCredential? userCredential;

//inisialisasi database firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  var userData = UserModel().obs;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserRoles() async* {
    var email = auth.currentUser!.email;
    yield* firestore.collection("users").doc(email).snapshots();
  }

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

      //inisiasi collection yg akan dipakai
      CollectionReference users = firestore.collection("users");

      String emailUser = auth.currentUser!.email.toString();

      users.doc(emailUser).update({
        "photoUrl": _currentUser!.photoUrl,
        "lastSignInTime":
            userCredential!.user!.metadata.lastSignInTime?.toIso8601String(),
      });

      isAuth.value = true;

      await Get.offAllNamed(Routes.HOME);
    } else {
      Get.dialog(
        Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white,
            child: SizedBox(
              width: 68.w,
              height: 32.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animation/failed.json', width: 28.w),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'BATAL LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: bluePrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Container(
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: white),
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: bluePrimary),
                            ),
                          ))),
                ],
              ),
            )),
      );
      Get.back();
    }
  }

  // Pendaftaran perangkat ke topik notifikasi
  Future<void> registerToNotificationTopic(String role) async {
    await FirebaseMessaging.instance.subscribeToTopic(role);
  }

// Menghapus perangkat dari topik notifikasi
  Future<void> unregisterFromNotificationTopic(String role) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(role);
  }

  Future<void> logout() async {
    CollectionReference users = firestore.collection("users");
    String emailUser = auth.currentUser!.email.toString();
    final checkuser = await users.doc(emailUser).get();
    final checkUserData = checkuser.data() as Map<String, dynamic>;
    unregisterFromNotificationTopic(checkUserData['roles']);
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

  // Future<DocumentSnapshot<Object?>> getUserRole() async {
  //   String? emailUser = auth.currentUser!.email;
  //   DocumentReference userss = firestore.collection("users").doc(emailUser);
  //   return userss.get();
  // }
}
