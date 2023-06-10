import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import 'package:intl/intl.dart' show DateFormat;

class TugasBosController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final dateFormatterDefault = DateFormat('yyyy-MM-dd');

  void pickRangeDate(DateTime pickStart, DateTime pickEnd) {
    filteredData.clear();

    for (var data in allData) {
      DateTime date = DateTime.parse(data['Tanggal Tenggat']);

      if (date.isAfter(pickStart) && date.isBefore(pickEnd)) {
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
    ;
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> tugasProses() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("Tugas")
        .where("Status", isEqualTo: 'Belum Selesai')
        .orderBy("Tanggal Tenggat", descending: true)
        .get();
    return querySnapshot.docs;
  }

  Future<void> editStatus(
    String doc,
    String status,
  ) async {
    try {
      CollectionReference users = firestore.collection("Tugas");
      await users.doc(doc).update({
        'Status': status,
      });

      Get.dialog(Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: bluePrimary,
          child: Container(
            width: 350,
            height: 336,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PhosphorIcons.checkCircleFill,
                  color: white,
                  size: 110,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'Tugas Diselesaikan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                    width: 15.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11), color: white),
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 11.0, bottom: 11.0),
                          child: Text(
                            'OK',
                            style: TextStyle(fontSize: 18, color: bluePrimary),
                          ),
                        )))
              ],
            ),
          )));
    } catch (e) {
      Get.dialog(Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: bluePrimary,
        child: Container(
          width: 350,
          height: 336,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Icon(
                  PhosphorIcons.xCircle,
                  color: white,
                  size: 110,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "Terjadi Kesalahan!",
                style: TextStyle(
                  fontSize: 30,
                  color: white,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                "Tidak Dapat Mengubah Data",
                style: TextStyle(
                  fontSize: 20,
                  color: white,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "$e",
                style: TextStyle(
                  color: white,
                ),
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
      await Future.delayed(Duration(milliseconds: 250));
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
