import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';

import '../../../util/color.dart';

class OlahDataPegawaiController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> olah() {
    return searchQuery
        .debounceTime(Duration(milliseconds: 300))
        .switchMap((query) {
      if (query.isEmpty) {
        return firestore
            .collection("users")
            .where('status', isEqualTo: 'true')
            .snapshots();
      } else {
        return firestore
            .collection("users")
            .where('status', isEqualTo: 'true')
            .where("name", isGreaterThanOrEqualTo: query)
            .where("name", isLessThanOrEqualTo: query + 'z')
            .snapshots();
      }
    });
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> olahSearch;

  final TextEditingController searchController = TextEditingController();
  final BehaviorSubject<String> searchQuery = BehaviorSubject<String>();

  // RxString searchQuery = ''.obs;

  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  var isSearching = false.obs;

  // void onSearchChanged(String value) {
  //   isSearching.value = true;
  //   // Memperbarui nilai pencarian setiap kali pengguna mengetik
  //   searchQuery.value = value;
  //   olah(searchQuery.value);
  // }

  Future<void> delKry(String docName) async {
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
                height: 1.h,
              ),
              Text(
                'Yakin Ingin Menghapus Data?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: bluePrimary,
                  fontSize: 15.sp,
                ),
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
                          borderRadius: BorderRadius.circular(8.sp),
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
                                  fontSize: 10.sp, color: bluePrimary),
                            ),
                          ))),
                  TextButton(
                      onPressed: () async {
                        CollectionReference users =
                            firestore.collection("users");
                        await users.doc(docName).update({'status': 'false'});
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset('assets/animation/check.json',
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
                            transitionDuration: Duration(milliseconds: 500));
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                        child: Text(
                          'HAPUS',
                          style: TextStyle(fontSize: 10.sp, color: bluePrimary),
                        ),
                      )),
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

  void increment() => count.value++;
}
