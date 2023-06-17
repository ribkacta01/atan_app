import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';

class KeranjangBosController extends GetxController {
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

  void dateMonthNow() {
    DateTime now = DateTime.now();
    int currentMonth = now.month;

    DateTime startDate = DateTime(now.year, currentMonth, now.day);
    DateTime endDate = DateTime(now.year, currentMonth + 1, now.day);

    filteredDataMonth.clear();

    for (var data in allData) {
      DateTime date = DateTime.parse(data['date']);
      if (date.isAfter(startDate) && date.isBefore(endDate)) {
        filteredDataMonth.add(data);
      }
    }
    print('RIBKA');
    update();
  }

  RxList<DocumentSnapshot<Map<String, dynamic>>> allData =
      RxList<DocumentSnapshot<Map<String, dynamic>>>();
  RxList<DocumentSnapshot<Map<String, dynamic>>> filteredData =
      RxList<DocumentSnapshot<Map<String, dynamic>>>();
  RxList<DocumentSnapshot<Map<String, dynamic>>> filteredDataMonth =
      RxList<DocumentSnapshot<Map<String, dynamic>>>();

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> documentsStream() {
    return searchQuery.debounceTime(300.milliseconds).switchMap((query) {
      if (query.isEmpty) {
        return firestore
            .collection("Perencanaan")
            // .where("date", isGreaterThanOrEqualTo: formattedStartDate)
            // .where("date", isLessThan: formattedEndDate)
            .orderBy("date", descending: true)
            .snapshots()
            .map((querySnapshot) => querySnapshot.docs);
      } else {
        String lowerCaseQuery = query.toLowerCase();
        return firestore
            .collection("Perencanaan")
            .where("nama", isGreaterThanOrEqualTo: query)
            .where("nama", isLessThanOrEqualTo: query + '\uf8ff')
            .snapshots()
            .map((querySnapshot) => querySnapshot.docs);
      }
    });
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> olahSearch;

  final TextEditingController searchController = TextEditingController();
  final BehaviorSubject<String> searchQuery = BehaviorSubject<String>();

  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  var isSearching = false.obs;

  Future<void> delData(String docName) async {
    Get.dialog(Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.sp)),
        backgroundColor: grey1,
        child: Container(
          width: 68.w,
          height: 32.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animation/alert.json', width: 28.w),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Yakin Ingin Menghapus Data?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: bluePrimary,
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 20.w,
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
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: bluePrimary),
                            ),
                          ))),
                  Container(
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: grey1),
                      child: TextButton(
                          onPressed: () async {
                            CollectionReference users =
                                firestore.collection("Perencanaan");
                            await users.doc(docName).delete();
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
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w800,
                                  color: bluePrimary),
                            ),
                          ))),
                ],
              )
            ],
          ),
        )));
  }

  @override
  void onInit() {
    super.onInit();
    searchQuery.add('');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchQuery.close();
    searchController.dispose();
  }

  // void increment() => count.value++;
}
