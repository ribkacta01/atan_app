// ignore_for_file: depend_on_referenced_packages, unused_local_variable, unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart' show DateFormat;

class BerandaBosController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

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

  Stream<QuerySnapshot<Map<String, dynamic>>> filteredDocs() {
    DateTime now = start!;
    int currentMonth = now.month;

    DateTime startDate = DateTime(now.year, currentMonth, 1);
    DateTime endDate = DateTime(now.year, currentMonth + 1, 1);

    String formattedStartDate = startDate.toIso8601String().substring(0, 10);
    String formattedEndDate = endDate.toIso8601String().substring(0, 10);
    return searchQuery.debounceTime(300.milliseconds).switchMap((query) {
      if (query.isEmpty) {
        return firestore
            .collection("Tugas")
            .where("Tanggal Pesan", isGreaterThanOrEqualTo: formattedStartDate)
            .where("Tanggal Pesan", isLessThan: formattedEndDate)
            .snapshots();
      } else {
        String lowerCaseQuery = query.toLowerCase();
        // String upperCaseQuery = query.toUpperCase();
        return firestore
            .collection("Tugas")
            .where("Tanggal Pesan", isGreaterThanOrEqualTo: formattedStartDate)
            .where("Tanggal Pesan", isLessThan: formattedEndDate)
            .where("Tanggal Pesan", isGreaterThan: start!.toIso8601String())
            .where("Tanggal Pesan",
                isLessThan:
                    end.value.add(const Duration(days: 1)).toIso8601String())
            .snapshots();
      }
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> berandaBos() async* {
    var email = auth.currentUser!.email;
    yield* firestore.collection("users").doc(email).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasPegProses() {
    return firestore
        .collection("Tugas")
        .where('photo', isEqualTo: '')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tugasPegDone() {
    return firestore
        .collection("Tugas")
        .where('photo', isNotEqualTo: '')
        .orderBy("photo", descending: false)
        .snapshots();
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> olahSearch;

  final TextEditingController searchController = TextEditingController();
  final BehaviorSubject<String> searchQuery = BehaviorSubject<String>();

  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  var isSearching = false.obs;

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
