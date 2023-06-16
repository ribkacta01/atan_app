import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import 'package:intl/intl.dart' show DateFormat;

class TugasBosController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final dateFormatterDefault = DateFormat('yyyy-MM-dd');

  Set<String> uniqueNames = Set<String>();

  void pickRangeDate(DateTime pickStart, DateTime pickEnd) {
    filteredData.clear();

    for (var data in allData) {
      DateTime date = DateTime.parse(data['Tanggal Tenggat']);

      if (date.day >= pickStart.day &&
          date.day <= pickEnd.day &&
          date.month >= pickStart.month &&
          date.month <= pickEnd.month &&
          date.year >= pickStart.year &&
          date.year <= pickEnd.year) {
        filteredData.add(data);
      }
    }
    update();
  }

  RxList<DocumentSnapshot<Map<String, dynamic>>> allData =
      RxList<DocumentSnapshot<Map<String, dynamic>>>();
  RxList<DocumentSnapshot<Map<String, dynamic>>> filteredData =
      RxList<DocumentSnapshot<Map<String, dynamic>>>();

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasList() async* {
    yield* firestore.collection("Tugas").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasDiv(
      String dataPemesan) async* {
    yield* firestore
        .collection("Tugas")
        .where("Nama Pemesan", isEqualTo: dataPemesan)
        .snapshots();
  }

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> tugasDone() {
    return firestore
        .collection("Tugas")
        .where("Status", isEqualTo: 'Selesai')
        .orderBy("Tanggal Tenggat", descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
  }

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> tugasProses() {
    return firestore
        .collection("Tugas")
        .where("Status", isEqualTo: 'Belum Selesai')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
  }

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> tugas() {
    return firestore
        .collection("Tugas")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
  }

  Future<void> editStatus(
    Iterable<DocumentSnapshot<Map<String, dynamic>>> doc,
    String status,
  ) async {
    try {
      CollectionReference users = firestore.collection("Tugas");
      for (var document in doc) {
        await users.doc(document.id).update({
          'Status': status,
        });
      }

      Get.dialog(Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.sp)),
          backgroundColor: grey1,
          child: SizedBox(
            width: 68.w,
            height: 32.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animation/check.json', width: 28.w),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Tugas Diselesaikan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: bluePrimary,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  width: 15.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.sp), color: white),
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 12.sp, color: bluePrimary),
                        ),
                      )),
                ),
                SizedBox(
                  height: 1.h,
                )
              ],
            ),
          )));
    } catch (e) {
      Get.dialog(Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.sp)),
        backgroundColor: bluePrimary,
        child: SizedBox(
          width: 68.w,
          height: 32.h,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child:
                    Lottie.asset('assets/animation/failed.json', width: 28.w),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Terjadi Kesalahan!",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: white,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                "Tidak Dapat Mengubah Data",
                style: TextStyle(
                  fontSize: 11.sp,
                  color: white,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ));
    }
  }

  var isChanged = (-1).obs;
  var isVisible = false.obs;

  void showWidgetWithDelay() async {}

  void toggleExpanded(int index) async {
    isChanged.value = isChanged.value == index ? -1 : index;
    if (isChanged.value == index) {
      await Future.delayed(const Duration(milliseconds: 250));
      isVisible.value = true;
    }
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
