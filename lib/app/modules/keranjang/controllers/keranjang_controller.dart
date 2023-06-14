import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';
import 'package:intl/intl.dart' show DateFormat;

class KeranjangController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final collection = FirebaseFirestore.instance.collection('Perencanaan');

  void pickRangeDate(DateTime pickStart, DateTime pickEnd) {
    filteredData.clear();

    for (var data in allData) {
      DateTime date = DateTime.parse(data['date']);

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

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> cart() {
    return firestore
        .collection("Perencanaan")
        .orderBy('date', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs);
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
