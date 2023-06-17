import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

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
    return searchQuery.debounceTime(300.milliseconds).switchMap((query) {
      if (query.isEmpty) {
        return firestore
            .collection("Perencanaan")
            .orderBy('date', descending: true)
            .snapshots()
            .map((querySnapshot) => querySnapshot.docs);
      } else {
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
