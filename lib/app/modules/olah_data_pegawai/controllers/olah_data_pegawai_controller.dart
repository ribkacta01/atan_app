import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
        return firestore.collection("users").snapshots();
      } else {
        String lowerCaseQuery = query.toLowerCase();
        String upperCaseQuery = query.toUpperCase();
        return firestore
            .collection("users")
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                'Yakin Ingin Menghapus Data?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: 25,
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
                          borderRadius: BorderRadius.circular(11),
                          color: white),
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 11.0, bottom: 11.0),
                            child: Text(
                              'BATAL',
                              style:
                                  TextStyle(fontSize: 18, color: bluePrimary),
                            ),
                          ))),
                  Container(
                      width: 15.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: white),
                      child: TextButton(
                          onPressed: () async {
                            CollectionReference users =
                                firestore.collection("users");
                            await users.doc(docName).delete();
                            Get.back();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 11.0, bottom: 11.0),
                            child: Text(
                              'HAPUS',
                              style:
                                  TextStyle(fontSize: 18, color: bluePrimary),
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
