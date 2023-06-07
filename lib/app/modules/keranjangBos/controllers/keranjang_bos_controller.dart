import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart' show DateFormat;

class KeranjangBosController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final collection = FirebaseFirestore.instance.collection('Perencanaan');

  // Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> keranjang() {
  //   return collection.orderBy('date').limit(perPage).snapshots().map(
  //         (snapshot) => snapshot.docs,
  //       );
  // }

  DateTime? start;
  final end = DateTime.now().obs;
  final dateFormatter = DateFormat('yyyy-MM-dd');

  void pickRangeDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end.value = pickEnd;
    update();
    var startFormatted = dateFormatter.format(start!);
    var endFormatted = dateFormatter.format(end.value);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> documentsStream() {
    DateTime now = DateTime.now();
    int currentMonth = now.month;

    DateTime startDate = DateTime(now.year, currentMonth, 1);
    DateTime endDate = DateTime(now.year, currentMonth + 1, 1);

    String formattedStartDate = startDate.toIso8601String().substring(0, 10);
    String formattedEndDate = endDate.toIso8601String().substring(0, 10);
    return searchQuery.debounceTime(300.milliseconds).switchMap((query) {
      if (query.isEmpty) {
        return firestore
            .collection("Perencanaan")
            .where("date", isGreaterThanOrEqualTo: formattedStartDate)
            .where("date", isLessThan: formattedEndDate)
            .orderBy("date", descending: true)
            .snapshots();
      }
      // else if (start == null) {
      //   return firestore
      //       .collection("Perencanaan")
      //       .where("date",
      //           isLessThan: end.value.toIso8601String().substring(0, 10))
      //       .orderBy("date", descending: true)
      //       .snapshots();
      // } else if (start != null) {
      //   return firestore
      //       .collection("Perencanaan")
      //       .where("date",
      //           isGreaterThan: start!.toIso8601String().substring(0, 10))
      //       .where("date",
      //           isLessThan: end.value
      //               .add(Duration(days: 1))
      //               .toIso8601String()
      //               .substring(0, 10))
      //       .orderBy("date", descending: true)
      //       .snapshots();
      // }
      else {
        String lowerCaseQuery = query.toLowerCase();
        // String upperCaseQuery = query.toUpperCase();
        return firestore
            .collection("Perencanaan")
            // .where("date", isGreaterThanOrEqualTo: formattedStartDate)
            // .where("date", isLessThan: formattedEndDate)`
            // .orderBy("date", descending: true)
            .where("nama", isGreaterThanOrEqualTo: query)
            .where("nama", isLessThanOrEqualTo: query + '\uf8ff')
            .snapshots();
      }
    });
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> filterDocs(String month) {
  //   DateTime month = DateTime.now();
  //   int currentMonth = month.month;
  //   return searchQuery;
  // }

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
