import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';

class ItemPesananKryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> item(String docName) async* {
    yield* firestore
        .collection("Perencanaan")
        .doc(docName)
        .collection('Kebutuhan')
        .snapshots();
  }

  Future<void> delItem(String docName, String docNameP) async {
    Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: grey1,
        child: Container(
          width: 68.w,
          height: 32.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animation/alert.json', width: 30.w),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Yakin Ingin Menghapus Data?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: bluePrimary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: white),
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                            child: Text(
                              'BATAL',
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: bluePrimary),
                            ),
                          ))),
                  Container(
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: grey1),
                      child: TextButton(
                          onPressed: () async {
                            CollectionReference perencanaan = firestore
                                .collection("Perencanaan")
                                .doc(docNameP)
                                .collection('Kebutuhan');
                            await perencanaan.doc(docName).delete();
                            Get.back();
                            await Get.dialog(
                                Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: grey1,
                                  child: Container(
                                    width: 68.w,
                                    height: 32.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(
                                            'assets/animation/check.json',
                                            width: 28.w),
                                        SizedBox(height: 3.h),
                                        Text(
                                          'Data Berhasil Dihapus',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: bluePrimary,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                transitionDuration:
                                    Duration(milliseconds: 500));
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                            child: Text(
                              'HAPUS',
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: bluePrimary),
                            ),
                          ))),
                ],
              )
            ],
          ),
        )));
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
