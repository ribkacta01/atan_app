import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart' show DateFormat;

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
